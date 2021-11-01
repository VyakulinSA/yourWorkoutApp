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
    
    func createWorkoutModule(router: RouterConfiguratorProtocol) -> UIViewController
    
    func createExercisesModule(router: RouterConfiguratorProtocol) -> UIViewController
}
 
class AssemblyConfigurator: AssembliConfiguratorProtocol {
    func createWorkoutModule(router: RouterConfiguratorProtocol) -> UIViewController{
        let presenter = WorkoutsPresenter(router: router)
        let view = WorkoutsViewController(presenter: presenter)
//        presenter.setupView(view: view)
        return view
    }
    
    func createStartMenuModule(router: RouterConfiguratorProtocol) -> UIViewController {
        let presenter = StartMenuPresenter(router: router)
        let view = StartMenuViewController(presenter: presenter)
//        presenter.setupView(view: view)
        return view
    }
    
    func createExercisesModule(router: RouterConfiguratorProtocol) -> UIViewController {
        let presenter = ExercisesPresenter(router: router)
        let view = ExercisesViewController(presenter: presenter)
        return view
        
    }
}
