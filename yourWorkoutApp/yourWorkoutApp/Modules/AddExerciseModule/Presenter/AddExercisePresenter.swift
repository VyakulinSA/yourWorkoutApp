//
//  AddExercisePresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 02.11.2021.
//

import Foundation

protocol AddExerciseViewInput: AnyObject {
    
}

protocol AddExerciseViewOutput: AnyObject {
    var exercisesData: [Exercise]? {get set}
    
    func backBarButtonTapped()
    func filterBarButtonTapped()
}

class AddExercisePresenter: AddExerciseViewOutput {
    private var router: RouterConfiguratorProtocol
    var exercisesData: [Exercise]?
    
    init(router: RouterConfiguratorProtocol){
        self.router = router
        getExercisesData()
    }
    
}

extension AddExercisePresenter {
    
    func backBarButtonTapped() {
        router.popVC()
    }
    
    func filterBarButtonTapped() {
        print(#function)
    }
    
    private func getExercisesData() {
//        exercisesData = [
//            Exercise(title: "Whole Body", muscleGroup: .wholeBody, description: "Whole Body description", startImage: nil, endImage: nil, workout: nil),
//            Exercise(title: "Back", muscleGroup: .back, description: "Back description", startImage: nil, endImage: nil, workout: nil),
//            Exercise(title: "Biceps", muscleGroup: .biceps, description: "Biceps description", startImage: nil, endImage: nil, workout: nil),
//            Exercise(title: "Chest", muscleGroup: .chest, description: "Chest description", startImage: nil, endImage: nil, workout: nil),
//            Exercise(title: "Triceps", muscleGroup: .triceps, description: "Triceps description", startImage: nil, endImage: nil, workout: nil),
//            Exercise(title: "Shoulders", muscleGroup: .shoulders, description: "Shoulders description", startImage: nil, endImage: nil, workout: nil),
//            Exercise(title: "Abs", muscleGroup: .abs, description: "Abs description", startImage: nil, endImage: nil, workout: nil),
//            Exercise(title: "Legs", muscleGroup: .legs, description: "Legs description", startImage: nil, endImage: nil, workout: nil),
//        ]
    }
    
}
