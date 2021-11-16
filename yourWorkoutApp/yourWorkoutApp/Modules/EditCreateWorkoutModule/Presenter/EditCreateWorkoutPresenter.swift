//
//  EditCreateWorkoutPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import Foundation
import UIKit

enum EditCreateWorkoutType {
    case edit
    case create
}

protocol EditCreateWorkoutViewInput: AnyObject {
}

protocol EditCreateWorkoutViewOutput: AnyObject {
    var workout: WorkoutModelProtocol {get set}
    var exercisesData: [ExerciseModelProtocol] {get set}
    var exercisesToDelete: [ExerciseModelProtocol] {get set}
    var editCreateType: EditCreateWorkoutType {get set}
    
    func backBarButtonTapped()
    func saveBarButtonTapped()
    func addBarButtonTapped()
    func trashBarButtonTapped()
    
    func detailButtonTapped(item: Int)
    
    func getImagesFromExercise(imageName: String?) -> UIImage?
}

class EditCreateWorkoutPresenter: EditCreateWorkoutViewOutput {
    
    var editCreateType: EditCreateWorkoutType
    var exercisesToDelete: [ExerciseModelProtocol] = [ExerciseModelProtocol]()
   
    weak var view: EditCreateWorkoutViewInput?
    
    private var router: RouterForEditCreateWorkoutModule
    private var imagesStorageManager: ImagesStorageManagerProtocol
    private var workoutStorageManager: DataStorageWorkoutManagerProtocol
    
    private var noUpdatedWorkout: WorkoutModelProtocol
    
    var workout: WorkoutModelProtocol
    var exercisesData: [ExerciseModelProtocol]
    
    init(workoutStorageManager: DataStorageWorkoutManagerProtocol, imagesStorageManager: ImagesStorageManagerProtocol, router: RouterForEditCreateWorkoutModule,
         editCreateType: EditCreateWorkoutType,  workout: WorkoutModelProtocol?) {
        self.router = router
        self.imagesStorageManager = imagesStorageManager
        self.workoutStorageManager = workoutStorageManager
        self.editCreateType = editCreateType
        
        if let workout = workout {
            self.workout = workout
            self.exercisesData = workout.exercises
        } else {
            self.exercisesData = [ExerciseModelProtocol]()
            self.workout = WorkoutModel(title: "", muscleGroups: [MuscleGroup](), system: false, exercises: self.exercisesData, id: UUID())
        }
        noUpdatedWorkout = self.workout
    }
}

extension EditCreateWorkoutPresenter {
    
    func backBarButtonTapped() {
        createWorkout()
        if compare(lhs: workout, rhs: noUpdatedWorkout) {
            router.popVC()
            return
        }
        router.showActionsForChangesAlert(output: self, acceptTitle: nil, deleteTitle: "Delete", titleString: "Exit without saving changes")
    }
    
    func saveBarButtonTapped(){
        switch editCreateType {
        case .edit:
            createWorkout()
            workout.title = workout.title == "" ? "Unknown workout" : workout.title
            workoutStorageManager.update(workout: workout)
            router.popVC(false)
        case .create:
            router.showActionsForChangesAlert(output: self, acceptTitle: "Save", deleteTitle: "Discard", titleString: "Create new workout")
        }
    }
    
    func addBarButtonTapped() {
        router.showAddExerciseViewController(delegate: self)
    }
    
    func trashBarButtonTapped() {
        exercisesData.removeAll(where: { exercise in
            var result = false
            for delEx in exercisesToDelete {
                if exercise.title == delEx.title{
                    result = true
                    break
                }
            }
            return result
        })
        exercisesToDelete.removeAll()
    }
    
    func detailButtonTapped(item: Int) {
        let exercise = exercisesData[item]
        router.showExerciseDetailViewController(exercise: exercise, editable: false)
    }
    
    func getImagesFromExercise(imageName: String?) -> UIImage? {
         return imagesStorageManager.load(imageName: imageName ?? "")
    }
    
    private func createWorkout() {
        workout.exercises = exercisesData
        workout.system = false
        let musclegroup = Set(exercisesData.map{$0.muscleGroup})
        workout.muscleGroups = Array(musclegroup)
    }
    
    private func compare(lhs: WorkoutModelProtocol, rhs: WorkoutModelProtocol) -> Bool {
        let lhsExercisesId = lhs.exercises.map{$0.id}
        let rhsExercisesId = rhs.exercises.map{$0.id}
        guard lhs.title == rhs.title, lhs.muscleGroups == rhs.muscleGroups,
              lhsExercisesId == rhsExercisesId else {return false}
        return true
    }
    
}

extension EditCreateWorkoutPresenter: ActionsForChangesAlertOutput {
    func accept() {
        switch editCreateType {
        case .edit:
            break
        case .create:
            createWorkout()
            workout.title = workout.title == "" ? "Unknown workout" : workout.title
            workoutStorageManager.create(workout: workout)
            router.popVC()
        }
    }
    
    func deleteChanges() {
        router.popVC()
    }
    
    
}
