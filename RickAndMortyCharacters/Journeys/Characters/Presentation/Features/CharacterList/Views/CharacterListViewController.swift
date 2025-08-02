//
//  CharacterListViewController.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import UIKit
import SwiftUI
import Combine

class CharacterListViewController: UIViewController {
    // MARK: - Properties
    private let tableView = UITableView()
    private let viewModel: any CharacterListViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    private var titleColor = UIColor(named: "Primary")
    weak var coordinator: CharacterListCoordinator?
    // MARK: - Initializer
    init(viewModel: any CharacterListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    // MARK: - Initializer
    required init?(coder: NSCoder) { fatalError() }
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupFilterHeader()
        bindViewModel()
        Task { await viewModel.loadInitial() }
    }
    // MARK: - View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
// MARK: - Setup
private extension CharacterListViewController {
    // MARK: - UI Setup
    private func setupUI() {
        title = "Characters"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: titleColor ?? UIColor.red]
        appearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? UIColor.red]
        navigationController?.navigationBar.standardAppearance = appearance
    }
    // MARK: - TableView Setup
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 110
        tableView.separatorStyle = .none
    }
    // MARK: - Filter Header Setup
    private func setupFilterHeader() {
        guard let listVM = viewModel as? CharacterListViewModel else { return }
        let filterView = CharacterFilterView(viewModel: listVM)
        let host = UIHostingController(rootView: filterView)
        host.view.backgroundColor = UIColor.clear
        addChild(host)
        host.view.translatesAutoresizingMaskIntoConstraints = false
        host.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 60)
        tableView.tableHeaderView = host.view
    }
    // MARK: - ViewModel Binding
    private func bindViewModel() {
        if let vm = viewModel as? CharacterListViewModel {
            vm.$characters
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    self?.tableView.reloadData()
                }
                .store(in: &cancellables)
            vm.$isLoading
                .receive(on: DispatchQueue.main)
                .sink { [weak self] isLoading in
                    guard let self = self else { return }

                    if isLoading {
                        // Remove existing activity indicator if present
                        self.view.viewWithTag(999)?.removeFromSuperview()
                        let indicator = UIActivityIndicatorView(style: .large)
                        indicator.tag = 999
                        indicator.translatesAutoresizingMaskIntoConstraints = false
                        self.view.addSubview(indicator)
                        NSLayoutConstraint.activate([
                            indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                            indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
                        ])
                        indicator.startAnimating()
                    } else {
                        self.view.viewWithTag(999)?.removeFromSuperview()
                    }
                }
                .store(in: &cancellables)
            
            vm.$errorMessage
                .receive(on: DispatchQueue.main)
                .sink { [weak self] errorMessage in
                    guard let self = self, let errorMessage = errorMessage else { return }
                    let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
                .store(in: &cancellables)
        }
    }
}
// MARK: - UITableViewDataSource & Delegate
extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let character = viewModel.characters[indexPath.row]
        
        let cellView = CharacterCellView(character: character)
        let host = UIHostingController(rootView: cellView)
        host.view.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(host.view)
        NSLayoutConstraint.activate([
            host.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            host.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.row]
        navigateToDetails(for: character)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let preloadFactor: CGFloat = 2
        let preloadDistance = scrollView.frame.height * preloadFactor
        let triggerPoint = scrollView.contentSize.height - preloadDistance
        if scrollView.contentOffset.y > triggerPoint {
            Task { await viewModel.loadMore() }
        }
    }
}
// MARK: - Navigation
extension CharacterListViewController {
    func navigateToDetails(for character: CharacterItem) {
        coordinator?.parent?.showCharacterDetailCoordinator(characterID: character.id)
    }
}
