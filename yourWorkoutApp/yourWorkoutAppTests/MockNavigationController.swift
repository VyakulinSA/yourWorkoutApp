//
//  MockNavigationController.swift
//  yourWorkoutAppTests
//
//  Created by Вякулин Сергей on 16.11.2021.
//

import Foundation
import UIKit
@testable import yourWorkoutApp

class MokNavigationController: YWNavigationController {
    var popCount = 0
    var presentCount = 0
    var pushCount = 0
    
    var controllerOnScreen: UIViewController?
    
    override func popViewController(animated: Bool) -> UIViewController? {
        popCount += 1
        return super.popViewController(animated: animated)
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        presentCount += 1
        controllerOnScreen = viewControllerToPresent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushCount += 1
        controllerOnScreen = viewController
    }
}
