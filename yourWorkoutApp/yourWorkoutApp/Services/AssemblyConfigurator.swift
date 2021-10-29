//
//  AssemblyConfigurator.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 28.10.2021.
//

import Foundation
import UIKit

protocol AssembliConfiguratorProtocol: AnyObject {
    func createStartMenuModule(router: RouterConfiguratorProtocol) -> UIViewController
}

class AssemblyConfigurator: AssembliConfiguratorProtocol {
    func createStartMenuModule(router: RouterConfiguratorProtocol) -> UIViewController {
        let presenter = StartMenuPresenter()
        let view = StartMenuViewController(presenter: presenter)
        presenter.setupView(view: view)
        return view
    }
}
