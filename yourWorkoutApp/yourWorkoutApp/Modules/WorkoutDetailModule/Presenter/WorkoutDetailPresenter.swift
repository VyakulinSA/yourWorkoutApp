//
//  WorkoutDetailPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 02.11.2021.
//

import Foundation
import UIKit


protocol WorkoutDetailViewInput: AnyObject {
    
}

protocol WorkoutDetailViewOutput: AnyObject {
    var exercisesData: [ExerciseModelProtocol]? {get set}
    var workout: WorkoutModelProtocol {get set}
    
    func backBarButtonTapped()
    func gearBarButtonTapped()
    func trashBarButtonTapped()
    
    func getImagesFromExercise(imageName: String?) -> UIImage?
    func getActualExercise()
}

class WorkoutDetailPresenter: WorkoutDetailViewOutput {
    private var router: RouterForWorkoutDetailModule
    private var workoutStorageManager: DataStorageWorkoutManagerProtocol
    private var imagesStorageManager: ImagesStorageManagerProtocol
    
    var exercisesData: [ExerciseModelProtocol]?
    var workout: WorkoutModelProtocol
    
    private var deleteWorkout = false
    
    init(workoutStorageManager: DataStorageWorkoutManagerProtocol, imagesStorageManager: ImagesStorageManagerProtocol, router: RouterForWorkoutDetailModule, workout: WorkoutModelProtocol){
        self.router = router
        self.workoutStorageManager = workoutStorageManager
        self.imagesStorageManager = imagesStorageManager
        self.exercisesData = workout.exercises
        self.workout = workout
        getExercisesData()
    }
    
}

extension WorkoutDetailPresenter {
    
    func backBarButtonTapped() {
        router.popVC()
    }
    
    func gearBarButtonTapped() {
        router.showEditCreateWorkoutViewController(editCreateType: .edit, workout: workout)
    }
    
    func trashBarButtonTapped() {
        deleteWorkout = true
        router.showActionsForChangesAlert(output: self, acceptTitle: nil, deleteTitle: "Delete", titleString: "Delete workout?")
    }
    
    private func getExercisesData() {
    }
    
    func getImagesFromExercise(imageName: String?) -> UIImage? {
         return imagesStorageManager.load(imageName: imageName ?? "")
    }
    func getActualExercise() {
        guard let actualWorkout = workoutStorageManager.readWorkout(id: workout.id) else {return}
        workout = actualWorkout
        self.exercisesData = actualWorkout.exercises
    }
    
}

extension WorkoutDetailPresenter: ActionsForChangesAlertOutput {
    func accept() {
        print(#function)
    }
    
    func deleteChanges() {
        if deleteWorkout {
            workoutStorageManager.delete(workout: workout)
            router.popToRoot()
            return
        }
    }
    
    
}
