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
    
    func showWorkoutsViewController()
    
    func showExercisesViewController()
    
    func showEditCreateWorkoutViewController(editCreateType: EditCreateWorkoutType, exercisesData: [Exercise]?)
    
    func showAddExerciseViewController()
    
    func popToRoot()
    
    func popVC()
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
    
    func showWorkoutsViewController() {
        if let navigationController = navigationController {
            guard let workoutsViewController = assemblyConfigurator?.createWorkoutModule(router: self) else {return}
            navigationController.viewControllers = [workoutsViewController]
        }
    }
    
    func showExercisesViewController() {
        if let navigationController = navigationController {
            guard let exercisesViewController = assemblyConfigurator?.createExercisesModule(router: self) else {return}
            navigationController.viewControllers = [exercisesViewController]
        }
    }
    
    func showEditCreateWorkoutViewController(editCreateType: EditCreateWorkoutType, exercisesData: [Exercise]?) {
        if let navigationController = navigationController {
            guard let editCreateWorkoutViewController = assemblyConfigurator?.createEditCreateWorkoutModule(router: self, editCreateType: editCreateType, exercisesData: exercisesData) else {return}
            navigationController.pushViewController(editCreateWorkoutViewController, animated: true)
        }
    }
    
    func showAddExerciseViewController() {
        if let navigationController = navigationController {
            guard let addExerciseViewCOntroller = assemblyConfigurator?.createAddExerciseModule(router: self) else {return}
            navigationController.pushViewController(addExerciseViewCOntroller, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    func popVC() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
}
