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
    
    func createEditCreateWorkoutModule(router: RouterConfiguratorProtocol, editCreateType: EditCreateWorkoutType) -> UIViewController
}
 
class AssemblyConfigurator: AssembliConfiguratorProtocol {
    func createWorkoutModule(router: RouterConfiguratorProtocol) -> UIViewController{
        let presenter = WorkoutsPresenter(router: router)
        let view = WorkoutsViewController(presenter: presenter)
        return view
    }
    
    func createStartMenuModule(router: RouterConfiguratorProtocol) -> UIViewController {
        let presenter = StartMenuPresenter(router: router)
        let view = StartMenuViewController(presenter: presenter)
        return view
    }
    
    func createExercisesModule(router: RouterConfiguratorProtocol) -> UIViewController {
        let presenter = ExercisesPresenter(router: router)
        let view = ExercisesViewController(presenter: presenter)
        return view
    }
    
    func createEditCreateWorkoutModule(router: RouterConfiguratorProtocol, editCreateType: EditCreateWorkoutType) -> UIViewController {
        let presenter = EditCreateWorkoutPresenter(router: router, editCreateType: editCreateType)
        let view = EditCreateWorkoutViewController(presenter: presenter)
        return view
    }
}
