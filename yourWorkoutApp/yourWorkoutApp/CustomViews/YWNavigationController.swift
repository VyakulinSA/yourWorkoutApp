//
//  YWNavigationController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 15.11.2021.
//

import UIKit

protocol NavigationControllerProtocol {
    var viewControllers: [UIViewController] { get set }
    var presentedViewController: UIViewController? {get}
    
    func popToRootViewController(animated: Bool)
    func popViewController(animated: Bool)
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func pushViewController(_ viewController: UIViewController, animated: Bool)
}

class YWNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
