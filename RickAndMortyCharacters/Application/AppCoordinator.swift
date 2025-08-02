//
//  AppCoordinator.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import UIKit

class AppCoordinator: NSObject, CoordinatorContract, ParentCoordinatorContract {
    var childCoordinators = [CoordinatorContract]()
    var navigationController: UINavigationController
    
    @MainActor func start(animated: Bool) {
        showCharacterListCoordinator()
    }
    
    override init() {
        navigationController = UINavigationController()
    }
    
    /**
     Appends the coordinator to the children array.
     - Parameters:
     - child: The child coordinator to be appended to the list.
     */
      func addChild(_ child: CoordinatorContract?){
        if let _child = child {
            childCoordinators.append(_child)
        }
    }
    
    /**
     Removes the child from children array.
     - Parameters:
     - child: The child coordinator to be removed from the list.
     */
    func childDidFinish(_ child: CoordinatorContract?) {
         guard let child = child else {
             return
         }
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func popViewController(animated: Bool, popType: PopType = .toPrevious) {
        navigationController.popViewController(animated: animated)
    }
    
    func removeAllChild() {
        for coordinator in childCoordinators {
            switch coordinator {
            case let childCoordinator as ChildCoordinatorContract:
                childCoordinator.viewControllerRef?.navigationController?.popViewController(animated: false)
                self.childDidFinish(childCoordinator)
            default:
                break
            }
        }
    }
}
