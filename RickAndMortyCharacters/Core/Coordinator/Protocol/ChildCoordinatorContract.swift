//
//  ChildCoordinator.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import UIKit

/// All Child coordinators should conform to this protocol
protocol ChildCoordinatorContract: AnyObject, CoordinatorContract {
    /**
     The body of this function should call `childDidFinish(_ child:)` on the parent coordinator to remove the child from parent's `childCoordinators`.
     */
    func coordinatorDidFinish()
    /// A reference to the view controller used in the coordinator.
    var viewControllerRef: UIViewController? {get set}
}

