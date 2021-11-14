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
    
    func createLeaguesModule(router: RouterForLeaguesModule) -> UIViewController
    func createStandingsModule(router: RouterForLeaguesModule, leaguesId: String) -> UIViewController
    
    func createEditCreateWorkoutModule( router: RouterForEditCreateWorkoutModule, editCreateType: EditCreateWorkoutType, workout: WorkoutModelProtocol?) -> UIViewController
    
    func createAddExerciseModule(router: RouterForAddExerciseModule, delegate: EditCreateWorkoutViewOutput) -> UIViewController
    
    func createWorkoutDetailModule(router: RouterForWorkoutDetailModule, workout: WorkoutModelProtocol) -> UIViewController
    
    func createEditCreateExerciseModule(router: RouterForEditCreateExerciseModule, editCreateType: EditCreateExerciseType, exercise: ExerciseModelProtocol?) -> UIViewController
    
    func createExerciseDetailModule(router: RouterForExerciseDetailModule, exercise: ExerciseModelProtocol, editable: Bool) -> UIViewController
    
    func createFilterExerciseModule(router: RouterForFilterExerciseModule, delegate: FilterExerciseProtocol) -> UIViewController
}
 
class AssemblyConfigurator: AssembliConfiguratorProtocol {
    let dataStack = CoreDataStack()
    var storageManager: CoreDataStorageManager {
        let storage = CoreDataStorageManager(managedObjectContext: dataStack.mainContext, coreDataStack: dataStack)
        return storage
    }
    
    let networkService = NetworkService()
    
    let imagesStorageManager: ImagesStorageManagerProtocol = ImagesStorageManager()
    
    
    func createWorkoutModule(router: RouterForWorkoutsModule) -> UIViewController{
        let presenter = WorkoutsPresenter(workoutStorageManager: storageManager,router: router)
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
    
    func createLeaguesModule(router: RouterForLeaguesModule) -> UIViewController {
        let presenter = LeaguesPresenter(router: router, networkService: networkService)
        let view = LeaguesViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createStandingsModule(router: RouterForLeaguesModule, leaguesId: String) -> UIViewController {
        return UIViewController()
    }
    
    func createEditCreateWorkoutModule(router: RouterForEditCreateWorkoutModule, editCreateType: EditCreateWorkoutType, workout: WorkoutModelProtocol?) -> UIViewController {
        let presenter = EditCreateWorkoutPresenter(workoutStorageManager: storageManager, imagesStorageManager: imagesStorageManager ,router: router, editCreateType: editCreateType, workout: workout)
        let view = EditCreateWorkoutViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createAddExerciseModule(router: RouterForAddExerciseModule, delegate: EditCreateWorkoutViewOutput) -> UIViewController {
        let presenter = AddExercisePresenter(imagesStorageManager: imagesStorageManager, exerciseStorageManager: storageManager, router: router, delegate: delegate)
        let view = AddExerciseViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createWorkoutDetailModule(router: RouterForWorkoutDetailModule, workout: WorkoutModelProtocol) -> UIViewController {
        let presenter = WorkoutDetailPresenter(workoutStorageManager: storageManager, imagesStorageManager: imagesStorageManager, router: router, workout: workout)
        let view = WorkoutDetailViewController(presenter: presenter)
        return view
    }
    
    func createEditCreateExerciseModule(router: RouterForEditCreateExerciseModule, editCreateType: EditCreateExerciseType, exercise: ExerciseModelProtocol?) -> UIViewController {
        let presenter = EditCreateExercisePresenter(exerciseStorageManager: storageManager, imagesStorageManager: imagesStorageManager, router: router, editCreateType: editCreateType, exercise: exercise)
        let view = EditCreateExerciseViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createExerciseDetailModule(router: RouterForExerciseDetailModule, exercise: ExerciseModelProtocol, editable: Bool) -> UIViewController {
        let presenter = ExerciseDetailPresenter(exerciseStorageManager: storageManager, imagesStorageManager: imagesStorageManager, router: router, exercise: exercise, editable: editable)
        let view = ExerciseDetailViewController(presenter: presenter)
        return view
    }
    
    func createFilterExerciseModule(router: RouterForFilterExerciseModule, delegate: FilterExerciseProtocol) -> UIViewController {
        let presenter = FilterExercisePresenter(router: router, delegate: delegate)
        let view = FilterExerciseViewController(presenter: presenter)
        return view
    }
}
