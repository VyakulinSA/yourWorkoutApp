//
//  EditCreateWorkoutPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import Foundation

enum EditCreateWorkoutType {
    case edit
    case create
}

protocol EditCreateWorkoutViewInput: AnyObject {
    
}

protocol EditCreateWorkoutViewOutput: AnyObject {
    var exercisesData: [Exercise]? {get set}
    var editCreateType: EditCreateWorkoutType {get set}
    
    func leftBarButtonTapped()
    
}

class EditCreateWorkoutPresenter: EditCreateWorkoutViewOutput {
    var editCreateType: EditCreateWorkoutType
    var exercisesData: [Exercise]?
    private var router: RouterConfiguratorProtocol
    
    init(router: RouterConfiguratorProtocol, editCreateType: EditCreateWorkoutType) {
        self.router = router
        self.editCreateType = editCreateType
        getExercisesData()
    }
    
}

extension EditCreateWorkoutPresenter {
    
    func leftBarButtonTapped() {
        router.popVC()
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