//
//  ExerciseDetailPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 04.11.2021.
//

import Foundation
import UIKit

protocol ExerciseDetailViewInput: AnyObject {
    
}

protocol ExerciseDetailViewOutput: AnyObject {
    var exercise: ExerciseModelProtocol {get set}
    
    func backBarButtonTapped()
    func editButtonTapped()
    
}

class ExerciseDetailPresenter: ExerciseDetailViewOutput {
    var exercise: ExerciseModelProtocol
    private var router: RouterForExerciseDetailModule
    
    init(router: RouterForExerciseDetailModule, exercise: ExerciseModelProtocol) {
        self.router = router
        self.exercise = exercise
        
        createExercise()
    }
    
}

extension ExerciseDetailPresenter {
    
    func backBarButtonTapped() {
        router.popVC()
    }
    
    func editButtonTapped() {
        router.showEditCreateExerciseViewController(editCreateType: .edit, exercise: exercise)
    }
    
    func createExercise() {

    }
}
