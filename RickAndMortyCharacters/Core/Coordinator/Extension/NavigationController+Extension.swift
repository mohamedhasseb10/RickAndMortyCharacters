//
//  NavigationController+Extension.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import UIKit
import QuartzCore

private let durationTime: CFTimeInterval = 0.0
enum VCTransition {
    case fromTop
    case fromBottom
    case fromLeft
    case fromRight
}

enum VCTransitionType: Int {
    case present
    case push
}

extension UINavigationController {
    // MARK: - POP VC
    /** Pops current view controller to previous view controller with a custom transition. */
    func customPopViewController(direction: VCTransition = .fromBottom, transitionType: CATransitionType = CATransitionType(rawValue: CATransitionType.push.rawValue)) {
        self.addTransition(transitionDirection: direction, transitionType: transitionType)
        self.popViewController(animated: false)
    }
    // MARK: - POP TO VC
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
    // MARK: - Custom POP TO VC
    func customPopToViewController(
        viewController vc: UIViewController, direction: VCTransition = .fromBottom,
        transitionType: CATransitionType = CATransitionType(rawValue: CATransitionType.push.rawValue)) {
            self.addTransition(transitionDirection: direction, transitionType: transitionType)
            self.popToViewController(vc, animated: false)
        }
    // MARK: - Custom POP TO ROOT
    func customPopToRootViewController(
        direction: VCTransition = .fromBottom,
        transitionType: CATransitionType = CATransitionType(rawValue: CATransitionType.push.rawValue)) {
            self.addTransition(transitionDirection: direction, transitionType: transitionType)
            self.popToRootViewController(animated: false)
    }
    // MARK: Dismiss VC
    func dismissViewController(animated: Bool) {
        self.dismiss(animated: animated)
    }
    // MARK: - CUSTOM PUSH VC
    func customPushViewController(viewController vc: UIViewController, direction: VCTransition = .fromTop, transitionType: CATransitionType = CATransitionType(rawValue: CATransitionType.push.rawValue)) {
        self.addTransition(transitionDirection: direction, transitionType: transitionType)
        self.pushViewController(vc, animated: false)
    }
    // MARK: - PRESENT VC
    func presentViewController(viewController vc: UIViewController) {
        DispatchQueue.main.async {
            let otherNav = UINavigationController(rootViewController: vc)
            otherNav.isNavigationBarHidden = true
            otherNav.navigationBar.barStyle = .default
            otherNav.navigationBar.isTranslucent = false
            otherNav.modalPresentationStyle = .fullScreen
            self.present(otherNav, animated: true, completion: nil)
        }
    }
    // MARK: - Transitions
    private func addTransition(
        transitionDirection direction: VCTransition,
        transitionType: CATransitionType = CATransitionType(rawValue: CATransitionType.push.rawValue)) {
        let transition = CATransition()
        transition.duration = durationTime
        transition.type = transitionType
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        switch direction {
        case .fromTop:
            transition.subtype = CATransitionSubtype.fromTop
        case .fromBottom:
            transition.subtype = CATransitionSubtype.fromBottom
        case .fromLeft:
            transition.subtype = CATransitionSubtype.fromLeft
        case .fromRight:
            transition.subtype = CATransitionSubtype.fromRight
        }
        self.view.layer.add(transition, forKey: nil)
    }
}
