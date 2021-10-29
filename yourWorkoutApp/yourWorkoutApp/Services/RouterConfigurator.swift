//
//  RouterConfigurator.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 28.10.2021.
//

import Foundation
import UIKit

protocol RouterConfiguratorProtocol {
    func initialViewController()
}


class RouterConfigurator: RouterConfiguratorProtocol {
    var navigationController: UINavigationController?
    var assemblyConfigurator: AssembliConfiguratorProtocol?
    
    init(navController: UINavigationController, assemblyConfigurator: AssembliConfiguratorProtocol) {
        self.navigationController = navController
        self.assemblyConfigurator = assemblyConfigurator
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let startMenuViewController = assemblyConfigurator?.createStartMenuModule(router: self) else {return}
            navigationController.viewControllers = [startMenuViewController]
        }
    }
    
}