//
//  EditCreateExercisePresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 04.11.2021.
//

import Foundation
enum EditCreateExerciseType {
    case edit
    case create
}

protocol EditCreateExerciseViewInput: AnyObject {
    
}

protocol EditCreateExerciseViewOutput: AnyObject {
    var exercise: Exercise? {get set}
    var editCreateType: EditCreateExerciseType {get set}
    
    func backBarButtonTapped()
    
}

class EditCreateExercisePresenter: EditCreateExerciseViewOutput {
    var editCreateType: EditCreateExerciseType
    var exercise: Exercise?
    private var router: RouterConfiguratorProtocol
    
    init(router: RouterConfiguratorProtocol, editCreateType: EditCreateExerciseType, exercise: Exercise?) {
        self.router = router
        self.editCreateType = editCreateType
        self.exercise = exercise
        getExercise()
    }
    
}

extension EditCreateExercisePresenter {
    
    func backBarButtonTapped() {
        router.popVC()
    }
    
    private func getExercise() {
//        exercise = Exercise(title: "TestExercise", muscleGroup: .biceps, description: "Biceps description", startImage: nil, endImage: nil, workout: nil)
    }
}
