//
//  Coordinator.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import UIKit

enum PopType: Int {
    case toPrevious
    case toVC
    case toRoot
}

/// Coordinator handles navigation within the app
protocol CoordinatorContract: AnyObject {
    /// The navigation controller for the coordinator
     var navigationController: UINavigationController { get set }
    /**
     The Coordinator takes control and activates itself.
     - Parameters:
        - animated: Set the value to true to animate the transition. Pass false if you are setting up a navigation controller before its view is displayed.
     
    */
    @MainActor func start(animated: Bool)
    /**
        Pops out the active View Controller from the navigation stack.
        - Parameters:
            - animated: Set this value to true to animate the transition.
     */
    func popViewController(animated: Bool, popType: PopType)
}
