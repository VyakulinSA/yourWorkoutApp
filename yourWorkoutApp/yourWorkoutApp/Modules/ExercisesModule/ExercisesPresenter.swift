//
//  ExercisesPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import Foundation
import UIKit

protocol ExercisesViewInput: AnyObject {
    func reloadCollection()
    
}

protocol ExercisesViewOutput: FilterExerciseProtocol {
    func getExercisesData()
    
    func startMenuButtonTapped()
    func createBarButtonTapped()
    func didSelectCell(item: Int)
    
    func getImagesFromExercise(imageName: String?) -> UIImage?
}

class ExercisesPresenter: ExercisesViewOutput {
    private var router: RouterForExerciseModule
    private var exerciseStorageManager: DataStorageExerciseManagerProtocol
    weak var view: ExercisesViewInput?
    private var imagesStorageManager: ImagesStorageManagerProtocol
    
    var exercisesData: [ExerciseModelProtocol]? {
        didSet {
            view?.reloadCollection()
        }
    }
    
    var selectedFilterMuscleGroups: [MuscleGroup]? {
        didSet {
            getExercisesData() //FIXME: Нужно ли каждый раз получать все упражнения? может хранить где то в константе, после первого получения, а тут просто восстанавливать.
            if selectedFilterMuscleGroups?.count ?? 0 > 0 {
                exercisesData = exercisesData?.filter({ exercise in
                    var filterResult = false
                    for muscle in selectedFilterMuscleGroups! {
                        if exercise.muscleGroup == muscle {
                            filterResult = true
                            break
                        }
                    }
                    return filterResult
                })
            }
            view?.reloadCollection()
        }
    }
    
    init(exerciseStorageManager: DataStorageExerciseManagerProtocol, imagesStorageManager: ImagesStorageManagerProtocol, router: RouterForExerciseModule){
        self.router = router
        self.exerciseStorageManager = exerciseStorageManager
        self.imagesStorageManager = imagesStorageManager
        getExercisesData()
    }
    
}

extension ExercisesPresenter {

    func startMenuButtonTapped() {
        router.initialViewController()
    }
    
    func filterBarButtonTapped() {
        router.showFilterExerciseViewConteroller(delegate: self)
    }
    func createBarButtonTapped(){
        router.showEditCreateExerciseViewController(editCreateType: .create, exercise: nil)
    }
    
    func didSelectCell(item: Int) {
        guard let exercise = exercisesData?[item] else {return}
        router.showExerciseDetailViewController(exercise: exercise)
    }
    
    func getExercisesData() {
        exercisesData = exerciseStorageManager.readAllExercises()
    }
    
    func getImagesFromExercise(imageName: String?) -> UIImage? {
         return imagesStorageManager.load(imageName: imageName ?? "")
    }
}
