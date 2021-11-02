//
//  WorkoutDetailPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 02.11.2021.
//

import Foundation


protocol WorkoutDetailViewInput: AnyObject {
    
}

protocol WorkoutDetailViewOutput: AnyObject {
    var exercisesData: [Exercise]? {get set}
    var workout: Workout {get set}
    
    func backBarButtonTapped()
    func gearBarButtonTapped()
}

class WorkoutDetailPresenter: WorkoutDetailViewOutput {
    private var router: RouterConfiguratorProtocol
    var exercisesData: [Exercise]?
    var workout: Workout
    
    init(router: RouterConfiguratorProtocol, exercisesData: [Exercise]?, workout: Workout){
        self.router = router
        self.exercisesData = exercisesData
        self.workout = workout
        getExercisesData()
    }
    
}

extension WorkoutDetailPresenter {
    
    func backBarButtonTapped() {
        router.popVC()
    }
    
    func gearBarButtonTapped() {
        router.showEditCreateWorkoutViewController(editCreateType: .edit, exercisesData: exercisesData)
    }
    
    private func getExercisesData() {
        workout = Workout(title: "Test Workout", countExercise: 10, muscleGroup: [.legs], system: false, exercises: nil)
        exercisesData = [
            Exercise(title: "Whole Body", muscleGroup: .wholeBody, description: "Whole Body description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Back", muscleGroup: .back, description: "Back description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Biceps", muscleGroup: .biceps, description: "Biceps description", startImage: nil, endImage: nil, workout: nil),
//            Exercise(title: "Chest", muscleGroup: .chest, description: "Chest description", startImage: nil, endImage: nil, workout: nil),
//            Exercise(title: "Triceps", muscleGroup: .triceps, description: "Triceps description", startImage: nil, endImage: nil, workout: nil),
//            Exercise(title: "Shoulders", muscleGroup: .shoulders, description: "Shoulders description", startImage: nil, endImage: nil, workout: nil),
//            Exercise(title: "Abs", muscleGroup: .abs, description: "Abs description", startImage: nil, endImage: nil, workout: nil),
//            Exercise(title: "Legs", muscleGroup: .legs, description: "Legs description", startImage: nil, endImage: nil, workout: nil),
        ]
    }
    
}
