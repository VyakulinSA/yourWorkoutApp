//
//  AddExercisePresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 02.11.2021.
//

import Foundation
import UIKit
import SwiftUI

protocol AddExerciseViewInput: AnyObject {
    func reloadCollection()
}

protocol AddExerciseViewOutput: FilterExerciseProtocol {
    func backBarButtonTapped()
    func getExercisesData()
    func detailButtonTapped(item: Int) 
    
    func getImagesFromExercise(imageName: String?) -> UIImage?
    
    func didSelectCell(item: Int)
}

class AddExercisePresenter: AddExerciseViewOutput {
    
    weak var view: AddExerciseViewInput?
    weak var delegate: EditCreateWorkoutViewOutput?
    
    private var router: RouterForAddExerciseModule
    private var exerciseStorageManager: DataStorageExerciseManagerProtocol
    private var imagesStorageManager: ImagesStorageManagerProtocol
    
    var exercisesData: [ExerciseModelProtocol]?
    
    var selectedFilterMuscleGroups: [MuscleGroup]? {
        didSet {
            getExercisesData()
            if selectedFilterMuscleGroups?.count ?? 0 > 0 {
                exercisesData = exercisesData?.filter({ exercise in
                    var filterResult = false
                    for muscle in selectedFilterMuscleGroups! {
                        if exercise.muscleGroup == muscle {
                            filterResult = true
                            break
                        } else {
                            filterResult = false
                        }
                    }
                    return filterResult
                })
            }
            view?.reloadCollection()
        }
    }
    
    init(imagesStorageManager: ImagesStorageManagerProtocol, exerciseStorageManager: DataStorageExerciseManagerProtocol,
         router: RouterForAddExerciseModule, delegate: EditCreateWorkoutViewOutput){
        self.router = router
        self.delegate = delegate
        self.exerciseStorageManager = exerciseStorageManager
        self.imagesStorageManager = imagesStorageManager
        getExercisesData()
    }
}

//MARK: Actions
extension AddExercisePresenter {
    
    func backBarButtonTapped() {
        router.popVC()
    }
    
    func filterBarButtonTapped() {
        router.showFilterExerciseViewConteroller(delegate: self)
    }
    
    func detailButtonTapped(item: Int) {
        guard let exercise = exercisesData?[item] else {return}
        router.showExerciseDetailViewController(exercise: exercise, editable: false)
    }
    
    func didSelectCell(item: Int) {
        guard let exercise = exercisesData?[item] else {return}
        delegate?.exercisesData.append(exercise)
        router.popVC(true)
    }
}

//MARK: Get data and images
extension AddExercisePresenter {
    func getExercisesData() {
        exercisesData = exerciseStorageManager.readAllExercises()
        guard let exercisesData = exercisesData else {return}
        self.exercisesData = exercisesData.filter { exercise in
            return !(self.delegate?.exercisesData.contains{$0.id == exercise.id} ?? false)
        }
    }
    
    func getImagesFromExercise(imageName: String?) -> UIImage? {
         return imagesStorageManager.load(imageName: imageName ?? "")
    }
}
