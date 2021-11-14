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
    var startExerciseImage: UIImage? {get set}
    var endExerciseImage: UIImage? {get set}
    var editable: Bool {get set}
    
    var exercise: ExerciseModelProtocol {get set}
    
    func backBarButtonTapped()
    func editButtonTapped()
    func getImagesFromExercise()
    func getActualExercise()
    
}

class ExerciseDetailPresenter: ExerciseDetailViewOutput {
    var startExerciseImage: UIImage?
    var endExerciseImage: UIImage?
    var editable: Bool
    
    var exercise: ExerciseModelProtocol
    private var router: RouterForExerciseDetailModule
    private var imagesStorageManager: ImagesStorageManagerProtocol
    private var exerciseStorageManager: DataStorageExerciseManagerProtocol
    
    
    init(exerciseStorageManager: DataStorageExerciseManagerProtocol,imagesStorageManager: ImagesStorageManagerProtocol, router: RouterForExerciseDetailModule, exercise: ExerciseModelProtocol, editable: Bool) {
        self.router = router
        self.exercise = exercise
        self.editable = editable
        self.exerciseStorageManager = exerciseStorageManager
        self.imagesStorageManager = imagesStorageManager
    }
    
}

//MARK: buttons actions
extension ExerciseDetailPresenter {
    
    func backBarButtonTapped() {
        router.popVC()
    }
    
    func editButtonTapped() {
        router.showEditCreateExerciseViewController(editCreateType: .edit, exercise: exercise)
    }
    
}

//MARK: helpers func
extension ExerciseDetailPresenter {
    func getImagesFromExercise() {
        startExerciseImage = imagesStorageManager.load(imageName: exercise.startImageName ?? "")
        endExerciseImage = imagesStorageManager.load(imageName: exercise.endImageName ?? "")
    }
    
    func getActualExercise() {
        guard let actualExercise = exerciseStorageManager.readExercise(id: exercise.id) else {return}
        exercise = actualExercise
    }
}
