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
    func popToRoot()
    func popVC()
    func popVC(_ animated: Bool)
    func showActionsForChangesAlert(output: ActionsForChangesAlertOutput, acceptTitle: String?, deleteTitle: String?, titleString: String?)
    func showMessageAlert(message: String)
}

protocol RouterForStartMenuModule: RouterConfiguratorProtocol {
    func showWorkoutsViewController()
    func showExercisesViewController()
    func showLeaguesViewController()
}

protocol RouterForLeaguesModule: RouterConfiguratorProtocol {
    func showStandingsViewController(leagueId: String) 
}

protocol RouterForWorkoutsModule: RouterConfiguratorProtocol {
    
    func showEditCreateWorkoutViewController(editCreateType: EditCreateWorkoutType, workout: WorkoutModelProtocol?)
    func showWorkoutDetailViewController(workout: WorkoutModelProtocol)
}

protocol RouterForExerciseModule: RouterConfiguratorProtocol {
    func showFilterExerciseViewConteroller(delegate: FilterExerciseProtocol)
    func showEditCreateExerciseViewController(editCreateType: EditCreateExerciseType, exercise: ExerciseModelProtocol?)
    func showExerciseDetailViewController(exercise: ExerciseModelProtocol, editable: Bool)
}

protocol RouterForAddExerciseModule: RouterConfiguratorProtocol {
    func showFilterExerciseViewConteroller(delegate: FilterExerciseProtocol)
    func showExerciseDetailViewController(exercise: ExerciseModelProtocol, editable: Bool)
}

protocol RouterForEditCreateWorkoutModule: RouterConfiguratorProtocol {
    func showAddExerciseViewController(delegate: EditCreateWorkoutViewOutput)
    func showExerciseDetailViewController(exercise: ExerciseModelProtocol, editable: Bool)
}

protocol RouterForWorkoutDetailModule: RouterConfiguratorProtocol {
    func showEditCreateWorkoutViewController(editCreateType: EditCreateWorkoutType, workout: WorkoutModelProtocol?)
    func showExerciseDetailViewController(exercise: ExerciseModelProtocol, editable: Bool)
}

protocol RouterForEditCreateExerciseModule: RouterConfiguratorProtocol {
    func showSelectExerciseImageActionsheet(output: SelectExerciseImageActionsheetOutput, selectedImageCell: SelectedImageCell)
    func showSelectExerciseImagePickerController(output: SelectExerciseImagePickerOutput, selectedImageCell: SelectedImageCell, source: UIImagePickerController.SourceType)
}

protocol RouterForExerciseDetailModule: RouterConfiguratorProtocol {
    func showEditCreateExerciseViewController(editCreateType: EditCreateExerciseType, exercise: ExerciseModelProtocol?)
}

protocol RouterForFilterExerciseModule: RouterConfiguratorProtocol {
    
}
 
public class RouterConfigurator: RouterConfiguratorProtocol, RouterForEditCreateExerciseModule, RouterForFilterExerciseModule {
    var navigationController: YWNavigationController?
    var assemblyConfigurator: AssembliConfiguratorProtocol?
    
    init(navController: YWNavigationController, assemblyConfigurator: AssembliConfiguratorProtocol) {
        self.navigationController = navController
        self.assemblyConfigurator = assemblyConfigurator
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let startMenuViewController = assemblyConfigurator?.createStartMenuModule(router: self) else {return}
            navigationController.viewControllers = [startMenuViewController]
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
    
    func showSelectExerciseImageActionsheet(output: SelectExerciseImageActionsheetOutput, selectedImageCell: SelectedImageCell){
        let actionSheet = SelectExerciseImageActionsheet(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.configure(output: output, selectedImageCell: selectedImageCell)
        navigationController?.present(actionSheet, animated: true, completion: nil)
    }
    
    func showSelectExerciseImagePickerController(output: SelectExerciseImagePickerOutput, selectedImageCell: SelectedImageCell, source: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = SelectExerciseImagePicker()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            imagePicker.configure(output: output, selectedImageCell: selectedImageCell)
            navigationController?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func showActionsForChangesAlert(output: ActionsForChangesAlertOutput, acceptTitle: String?, deleteTitle: String?, titleString: String?){
        let alert = ActionsForChangesAlert(title: nil, message: nil, preferredStyle: .alert)
        alert.configure(output: output, acceptTitle: acceptTitle, deleteTitle: deleteTitle, titleString: titleString)
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func showMessageAlert(message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func showEditCreateWorkoutViewController(editCreateType: EditCreateWorkoutType, workout: WorkoutModelProtocol?) {
        if let navigationController = navigationController {
            guard let editCreateWorkoutViewController = assemblyConfigurator?.createEditCreateWorkoutModule(router: self, editCreateType: editCreateType, workout: workout) else {return}
            let animated = editCreateType == .create ? true : false
            navigationController.pushViewController(editCreateWorkoutViewController, animated: animated)
        }
    }
}

extension RouterConfigurator: RouterForStartMenuModule {
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
    
    func showLeaguesViewController() {
        if let navigationController = navigationController {
            guard let standingsViewController = assemblyConfigurator?.createLeaguesModule(router: self) else {return}
            navigationController.viewControllers = [standingsViewController]
        }
    }
}

extension RouterConfigurator: RouterForWorkoutsModule, RouterForWorkoutDetailModule {

    
    func showWorkoutDetailViewController(workout: WorkoutModelProtocol) {
        if let navigationController = navigationController {
            guard let workoutDetailViewController = assemblyConfigurator?.createWorkoutDetailModule(router: self, workout: workout) else {return}
            navigationController.pushViewController(workoutDetailViewController, animated: true)
        }
    }
}

extension RouterConfigurator: RouterForExerciseModule, RouterForAddExerciseModule,RouterForExerciseDetailModule {
    
    func showEditCreateExerciseViewController(editCreateType: EditCreateExerciseType, exercise: ExerciseModelProtocol?) {
        if let navigationController = navigationController {
            guard let editCreateExerciseViewController = assemblyConfigurator?.createEditCreateExerciseModule(router: self, editCreateType: editCreateType, exercise: exercise) else {return}
            navigationController.pushViewController(editCreateExerciseViewController, animated: true)
        }
    }
    
    func showExerciseDetailViewController(exercise: ExerciseModelProtocol, editable: Bool) {
        if let navigationController = navigationController {
            guard let exerciseDetailViewController = assemblyConfigurator?.createExerciseDetailModule(router: self, exercise: exercise, editable: editable) else {return}
            navigationController.pushViewController(exerciseDetailViewController, animated: true)
        }
    }
    
    func showFilterExerciseViewConteroller(delegate: FilterExerciseProtocol) {
        if let navigationController = navigationController {
        guard let filterExerciseViewController = assemblyConfigurator?.createFilterExerciseModule(router: self, delegate: delegate) else {return}
            navigationController.present(filterExerciseViewController, animated: true, completion: nil)
        }
    }
}

extension RouterConfigurator: RouterForEditCreateWorkoutModule {
    func showAddExerciseViewController(delegate: EditCreateWorkoutViewOutput) {
        if let navigationController = navigationController {
            guard let addExerciseViewController = assemblyConfigurator?.createAddExerciseModule(router: self, delegate: delegate) else {return}
            navigationController.pushViewController(addExerciseViewController, animated: true)
        }
    }
}

extension RouterConfigurator: RouterForLeaguesModule {
    func showStandingsViewController(leagueId: String) {
        if let navigationController = navigationController {
            guard let standingsViewController = assemblyConfigurator?.createStandingsModule(router: self, leaguesId: leagueId) else {return}
            navigationController.pushViewController(standingsViewController, animated: true)
        }
    }
}
