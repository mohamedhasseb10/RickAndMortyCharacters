//
//  CharacterListCoordinator.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 01/08/2025.
//

import UIKit

class CharacterListCoordinator: NSObject, ChildCoordinatorContract {
    var viewControllerRef: UIViewController?
    var parent: AppCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @MainActor
    func start(animated: Bool = false) {
        let characterListVC = CharacterListViewController(viewModel: CharacterListViewModel())
        viewControllerRef = characterListVC
        characterListVC.coordinator = self
        navigationController.pushViewController(characterListVC, animated: animated)
    }
    
    func coordinatorDidFinish() {
        var viewControllers = navigationController.viewControllers
        viewControllers = viewControllers.filter { !$0.isKind(of: CharacterListViewController.self)}
        navigationController.setViewControllers(viewControllers, animated: true)
        parent?.childDidFinish(self)
    }
    
    func popViewController(animated: Bool, popType: PopType = .toPrevious) {
        navigationController.popViewController(animated: animated)
    }
}
