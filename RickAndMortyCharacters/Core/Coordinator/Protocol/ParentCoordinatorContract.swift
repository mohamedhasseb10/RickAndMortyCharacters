//
//  ParentCoordinator.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation

/// All the top-level coordinators should conform to this protocol
protocol ParentCoordinatorContract: CoordinatorContract {
    /// Each Coordinator can have its own children coordinators
    var childCoordinators: [CoordinatorContract] { get set }
    /**
     Adds the given coordinator to the list of children.
     - Parameters:
        - child: A coordinator.
     */
    func addChild(_ child: CoordinatorContract?)
    /**
     Tells the parent coordinator that given coordinator is done and should be removed from the list of children.
     - Parameters:
        - child: A coordinator.
     */
    func childDidFinish(_ child: CoordinatorContract?)
}
