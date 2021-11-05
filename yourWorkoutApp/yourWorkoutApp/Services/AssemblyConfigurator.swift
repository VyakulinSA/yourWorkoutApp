//
//  AssemblyConfigurator.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 28.10.2021.
//

import Foundation
import UIKit

protocol AssembliConfiguratorProtocol: AnyObject {
    func createStartMenuModule(router: RouterForStartMenuModule) -> UIViewController
    
    func createWorkoutModule(router: RouterForWorkoutsModule) -> UIViewController
    
    func createExercisesModule(router: RouterForExerciseModule) -> UIViewController
    
    func createEditCreateWorkoutModule(router: RouterForEditCreateWorkoutModule, editCreateType: EditCreateWorkoutType, exercisesData: [Exercise]?) -> UIViewController
    
    func createAddExerciseModule(router: RouterForAddExerciseModule) -> UIViewController
    
    func createWorkoutDetailModule(router: RouterForWorkoutDetailModule, workout: Workout) -> UIViewController
    
    func createEditCreateExerciseModule(router: RouterForEditCreateExerciseModule, editCreateType: EditCreateExerciseType, exercise: Exercise?) -> UIViewController
    
    func createExerciseDetailModule(router: RouterForExerciseDetailModule, exercise: Exercise) -> UIViewController
    
    func createFilterExerciseModule(router: RouterForFilterExerciseModule, delegate: FilterExerciseProtocol) -> UIViewController
}
 
class AssemblyConfigurator: AssembliConfiguratorProtocol {
    func createWorkoutModule(router: RouterForWorkoutsModule) -> UIViewController{
        let presenter = WorkoutsPresenter(router: router)
        let view = WorkoutsViewController(presenter: presenter)
        return view
    }
    
    func createStartMenuModule(router: RouterForStartMenuModule) -> UIViewController {
        let presenter = StartMenuPresenter(router: router)
        let view = StartMenuViewController(presenter: presenter)
        return view
    }
    
    func createExercisesModule(router: RouterForExerciseModule) -> UIViewController {
        let presenter = ExercisesPresenter(router: router)
        let view = ExercisesViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createEditCreateWorkoutModule(router: RouterForEditCreateWorkoutModule, editCreateType: EditCreateWorkoutType, exercisesData: [Exercise]?) -> UIViewController {
        let presenter = EditCreateWorkoutPresenter(router: router, editCreateType: editCreateType, exercisesData: exercisesData)
        let view = EditCreateWorkoutViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createAddExerciseModule(router: RouterForAddExerciseModule) -> UIViewController {
        let presenter = AddExercisePresenter(router: router)
        let view = AddExerciseViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createWorkoutDetailModule(router: RouterForWorkoutDetailModule, workout: Workout) -> UIViewController {
        let presenter = WorkoutDetailPresenter(router: router, workout: workout)
        let view = WorkoutDetailViewController(presenter: presenter)
        return view
    }
    
    func createEditCreateExerciseModule(router: RouterForEditCreateExerciseModule, editCreateType: EditCreateExerciseType, exercise: Exercise?) -> UIViewController {
        let presenter = EditCreateExercisePresenter(router: router, editCreateType: editCreateType, exercise: exercise)
        let view = EditCreateExerciseViewController(presenter: presenter)
        return view
    }
    
    func createExerciseDetailModule(router: RouterForExerciseDetailModule, exercise: Exercise) -> UIViewController {
        let presenter = ExerciseDetailPresenter(router: router, exercise: exercise)
        let view = ExerciseDetailViewController(presenter: presenter)
        return view
    }
    
    func createFilterExerciseModule(router: RouterForFilterExerciseModule, delegate: FilterExerciseProtocol) -> UIViewController {
        let presenter = FilterExercisePresenter(router: router, delegate: delegate)
        let view = FilterExerciseViewController(presenter: presenter)
        return view
    }
}
