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
    var exercise: Exercise {get set}
    
    func backBarButtonTapped()
    func editButtonTapped()
    
}

class ExerciseDetailPresenter: ExerciseDetailViewOutput {
    var exercise: Exercise
    private var router: RouterForExerciseDetailModule
    
    init(router: RouterForExerciseDetailModule, exercise: Exercise) {
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
//        let startImageData = UIImage(named: "exTestImage")?.pngData()
//        let endImageData = UIImage(named: "exTestImage2")?.pngData()
//        exercise = Exercise(title: "Create Biceps", muscleGroup: .biceps, description: "Up and down gantel", startImage: startImageData, endImage: endImageData, workout: nil)
    }
}
