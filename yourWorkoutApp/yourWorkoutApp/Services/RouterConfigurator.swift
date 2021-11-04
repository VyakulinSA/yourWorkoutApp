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
    
    func showWorkoutDetailViewController(exercisesData: [Exercise]?, workout: Workout)
    
    func showEditCreateExerciseViewController(editCreateType: EditCreateExerciseType, exercise: Exercise?)
    
    func showExerciseDetailViewController(exercise: Exercise)
    
    func popToRoot()
    
    func popVC()
    
    func popVC(_ animated: Bool)
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
            let animated = editCreateType == .create ? true : false
            navigationController.pushViewController(editCreateWorkoutViewController, animated: animated)
        }
    }
    
    func showAddExerciseViewController() {
        if let navigationController = navigationController {
            guard let addExerciseViewController = assemblyConfigurator?.createAddExerciseModule(router: self) else {return}
            navigationController.pushViewController(addExerciseViewController, animated: true)
        }
    }
    
    func showWorkoutDetailViewController(exercisesData: [Exercise]?, workout: Workout) {
        if let navigationController = navigationController {
            guard let workoutDetailViewController = assemblyConfigurator?.createWorkoutDetailModule(router: self, exercisesData: exercisesData, workout: workout) else {return}
            navigationController.pushViewController(workoutDetailViewController, animated: true)
        }
    }
    
    func showEditCreateExerciseViewController(editCreateType: EditCreateExerciseType, exercise: Exercise?) {
        if let navigationController = navigationController {
            guard let editCreateExerciseViewController = assemblyConfigurator?.createEditCreateExerciseModule(router: self, editCreateType: editCreateType, exercise: exercise) else {return}
            navigationController.pushViewController(editCreateExerciseViewController, animated: true)
        }
    }
    
    func showExerciseDetailViewController(exercise: Exercise) {
        if let navigationController = navigationController {
            guard let exerciseDetailViewController = assemblyConfigurator?.createExerciseDetailModule(router: self, exercise: exercise) else {return}
            navigationController.pushViewController(exerciseDetailViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    func popVC(_ animated: Bool) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: animated)
        }
    }
    
    func popVC() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
}
