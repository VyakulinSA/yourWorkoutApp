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
    
    func createEditCreateWorkoutModule( router: RouterForEditCreateWorkoutModule, editCreateType: EditCreateWorkoutType, exercisesData: [ExerciseModelProtocol]?) -> UIViewController
    
    func createAddExerciseModule(router: RouterForAddExerciseModule) -> UIViewController
    
    func createWorkoutDetailModule(router: RouterForWorkoutDetailModule, workout: WorkoutModelProtocol) -> UIViewController
    
    func createEditCreateExerciseModule(router: RouterForEditCreateExerciseModule, editCreateType: EditCreateExerciseType, exercise: ExerciseModelProtocol?) -> UIViewController
    
    func createExerciseDetailModule(router: RouterForExerciseDetailModule, exercise: ExerciseModelProtocol) -> UIViewController
    
    func createFilterExerciseModule(router: RouterForFilterExerciseModule, delegate: FilterExerciseProtocol) -> UIViewController
}
 
class AssemblyConfigurator: AssembliConfiguratorProtocol {
    let dataStack = CoreDataStack()
    var storageManager: CoreDataStorageManager {
        let storage = CoreDataStorageManager(managedObjectContext: dataStack.mainContext, coreDataStack: dataStack)
        return storage
    }
    
    let imagesStorageManager: ImagesStorageManagerProtocol = ImagesStorageManager()
    
    
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
        let presenter = ExercisesPresenter(exerciseStorageManager: storageManager, imagesStorageManager: imagesStorageManager, router: router)
        let view = ExercisesViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createEditCreateWorkoutModule(router: RouterForEditCreateWorkoutModule, editCreateType: EditCreateWorkoutType, exercisesData: [ExerciseModelProtocol]?) -> UIViewController {
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
    
    func createWorkoutDetailModule(router: RouterForWorkoutDetailModule, workout: WorkoutModelProtocol) -> UIViewController {
        let presenter = WorkoutDetailPresenter(router: router, workout: workout)
        let view = WorkoutDetailViewController(presenter: presenter)
        return view
    }
    
    func createEditCreateExerciseModule(router: RouterForEditCreateExerciseModule, editCreateType: EditCreateExerciseType, exercise: ExerciseModelProtocol?) -> UIViewController {
        let presenter = EditCreateExercisePresenter(exerciseStorageManager: storageManager, imagesStorageManager: imagesStorageManager, router: router, editCreateType: editCreateType, exercise: exercise)
        let view = EditCreateExerciseViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createExerciseDetailModule(router: RouterForExerciseDetailModule, exercise: ExerciseModelProtocol) -> UIViewController {
        let presenter = ExerciseDetailPresenter(exerciseStorageManager: storageManager, imagesStorageManager: imagesStorageManager, router: router, exercise: exercise)
        let view = ExerciseDetailViewController(presenter: presenter)
        return view
    }
    
    func createFilterExerciseModule(router: RouterForFilterExerciseModule, delegate: FilterExerciseProtocol) -> UIViewController {
        let presenter = FilterExercisePresenter(router: router, delegate: delegate)
        let view = FilterExerciseViewController(presenter: presenter)
        return view
    }
}
