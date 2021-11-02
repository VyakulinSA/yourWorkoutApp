//
//  ExercisesPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import Foundation

protocol ExercisesViewInput: AnyObject {
    
    
}

protocol ExercisesViewOutput: AnyObject {
    var exercisesData: [Exercise]? {get set}

    func startMenuButtonTapped()
    
}


class ExercisesPresenter: ExercisesViewOutput {
    
    var exercisesData: [Exercise]?
    var router: RouterConfiguratorProtocol
    
    init(router: RouterConfiguratorProtocol){
        self.router = router
        getExercisesData()
    }
    
}

extension ExercisesPresenter {

    func startMenuButtonTapped() {
        router.initialViewController()
    }
    
    private func getExercisesData() {
        exercisesData = [
            Exercise(title: "Whole Body", muscleGroup: .wholeBody, description: "Whole Body description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Back", muscleGroup: .back, description: "Back description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Biceps", muscleGroup: .biceps, description: "Biceps description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Chest", muscleGroup: .chest, description: "Chest description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Triceps", muscleGroup: .triceps, description: "Triceps description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Shoulders", muscleGroup: .shoulders, description: "Shoulders description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Abs", muscleGroup: .abs, description: "Abs description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Legs", muscleGroup: .legs, description: "Legs description", startImage: nil, endImage: nil, workout: nil),
        ]
    }
}
