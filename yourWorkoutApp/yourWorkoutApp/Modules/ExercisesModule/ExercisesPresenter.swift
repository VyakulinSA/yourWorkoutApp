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
            getExercisesData()
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
        createDefaultExercises()
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
        router.showExerciseDetailViewController(exercise: exercise, editable: true)
    }
    
    func getExercisesData() {
        exercisesData = exerciseStorageManager.readAllExercises()
    }
    
    func getImagesFromExercise(imageName: String?) -> UIImage? {
         return imagesStorageManager.load(imageName: imageName ?? "")
    }
}

//MARK: create default exercises
extension ExercisesPresenter {
    private func createDefaultExercises() {
        guard !UserDefaults.standard.bool(forKey: "firstStart") else {return}
        
        let ex1Id = UUID()
        let ex2Id = UUID()
        let ex3Id = UUID()
        
        let startImage_ex1 = imagesStorageManager.save(image: UIImage(named: "startImage_ex1"), withName: "\(ex1Id)_startImage")
        let endImage_ex1 = imagesStorageManager.save(image: UIImage(named: "endImage_ex1"), withName: "\(ex1Id)_endImage")
        
        let startImage_ex2 = imagesStorageManager.save(image: UIImage(named: "startImage_ex2"), withName: "\(ex2Id)_startImage")
        let endImage_ex2 = imagesStorageManager.save(image: UIImage(named: "endImage_ex2"), withName: "\(ex2Id)_endImage")
        
        let startImage_ex3 = imagesStorageManager.save(image: UIImage(named: "startImage_ex3"), withName: "\(ex3Id)_startImage")
        let endImage_ex3 = imagesStorageManager.save(image: UIImage(named: "endImage_ex3"), withName: "\(ex3Id)_endImage")
        
        let defaultExercises: [ExerciseModel] = [
            ExerciseModel(title: "Exercise 1", muscleGroup: .biceps,
                          description: "Biceps exercise", startImageName: startImage_ex1,
                          endImageName: endImage_ex1, id: ex1Id),
            ExerciseModel(title: "Exercise 2", muscleGroup: .chest,
                          description: "Chest exercise", startImageName: startImage_ex2,
                          endImageName: endImage_ex2, id: ex2Id),
            ExerciseModel(title: "Exercise 3", muscleGroup: .shoulders,
                          description: "Shoulders exercise", startImageName: startImage_ex3,
                          endImageName: endImage_ex3, id: ex3Id),
        ]
        
        exerciseStorageManager.create(exercise: defaultExercises[0])
        exerciseStorageManager.create(exercise: defaultExercises[1])
        exerciseStorageManager.create(exercise: defaultExercises[2])
        
        UserDefaults.standard.setValue(true, forKey: "firstStart")
    }
}
