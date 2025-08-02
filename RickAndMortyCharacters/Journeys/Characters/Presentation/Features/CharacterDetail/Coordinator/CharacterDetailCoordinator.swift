//
//  CharacterDetail.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 01/08/2025.
//

import UIKit

class CharacterDetailCoordinator: NSObject, ChildCoordinatorContract {
    var viewControllerRef: UIViewController?
    var parent: AppCoordinator?
    var navigationController: UINavigationController
    var characterID: Int
    init(navigationController: UINavigationController, characterID: Int) {
        self.navigationController = navigationController
        self.characterID = characterID
    }
    
    @MainActor func start(animated: Bool = false) {
        let characterListVC = CharacterDetailViewController(characterID: characterID,
                                                            viewModel: CharacterDetailViewModel())
        viewControllerRef = characterListVC
        characterListVC.coordinator = self
        navigationController.pushViewController(characterListVC, animated: animated)
        print(navigationController.viewControllers)
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
