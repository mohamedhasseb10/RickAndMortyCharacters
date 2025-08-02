//
//  CharacterDetailViewController.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import UIKit
import SwiftUI
import Combine

class CharacterDetailViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: CharacterDetailViewModelProtocol
    private let characterID: Int
    private var cancellables = Set<AnyCancellable>()
    weak var coordinator: CharacterDetailCoordinator?
    // MARK: - Initializer
    init(characterID: Int, viewModel: CharacterDetailViewModelProtocol) {
        self.viewModel = viewModel
        self.characterID = characterID
        super.init(nibName: nil, bundle: nil)
    }
    // MARK: - Initializer
    required init?(coder: NSCoder) { fatalError() }
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bindViewModel()
        loadCharacterDetails()
    }
    // MARK: - ViewModel Binding
    private func bindViewModel() {
        if let vm = viewModel as? CharacterDetailViewModel {
            vm.$errorMessage
                .receive(on: DispatchQueue.main)
                .sink { [weak self] errorMessage in
                    guard let self = self, let errorMessage = errorMessage else { return }
                    let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
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
        }
    }
}
// MARK: - Private Methods
extension CharacterDetailViewController {
    //MARK: - Load Character Details
    private func loadCharacterDetails() {
        Task {
            await viewModel.load(id: characterID)
            guard let character = viewModel.character else { return }
            addDetailView(for: character)
        }
    }
    // MARK: - Add Detail View
    private func addDetailView(for character: CharacterItem) {
        let detailView = CharacterDetailView(
            character: character,
            onBack: { [weak self] in
                guard let self = self else { return }
                self.coordinator?.popViewController(animated: true) }
        )
        let host = UIHostingController(rootView: detailView)
        addChild(host)
        host.view.translatesAutoresizingMaskIntoConstraints = false
        host.view.backgroundColor = .clear
        view.addSubview(host.view)
        NSLayoutConstraint.activate([
            host.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            host.view.topAnchor.constraint(equalTo: view.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        host.didMove(toParent: self)
    }
}
