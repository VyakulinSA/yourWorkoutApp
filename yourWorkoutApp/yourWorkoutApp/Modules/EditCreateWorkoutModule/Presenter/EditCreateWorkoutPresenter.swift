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
    func reloadCollection()
}

protocol EditCreateWorkoutViewOutput: AnyObject {
    var exercisesData: [Exercise]? {get set}
    var exercisesToDelete: [Exercise] {get set}
    var editCreateType: EditCreateWorkoutType {get set}
    
    func backBarButtonTapped()
    func saveBarButtonTapped()
    func addBarButtonTapped()
    func trashBarButtonTapped()
    
}

class EditCreateWorkoutPresenter: EditCreateWorkoutViewOutput {
    var editCreateType: EditCreateWorkoutType
    var exercisesToDelete: [Exercise] = [Exercise]()
    var exercisesData: [Exercise]? {
        didSet {
            view?.reloadCollection()
        }
    }
    
    weak var view: EditCreateWorkoutViewInput?
    
    private var router: RouterForEditCreateWorkoutModule
    
    
    init(router: RouterForEditCreateWorkoutModule, editCreateType: EditCreateWorkoutType, exercisesData: [Exercise]?) {
        self.router = router
        self.editCreateType = editCreateType
        self.exercisesData = exercisesData
        getExercisesData()
    }
    
}

extension EditCreateWorkoutPresenter {
    
    func backBarButtonTapped() {
        router.popVC()
    }
    
    func saveBarButtonTapped(){
        router.popVC(false)
    }
    
    func addBarButtonTapped() {
        router.showAddExerciseViewController()
    }
    
    func trashBarButtonTapped() {
        //удаляем только из коллекции, потом при сохранении перебираем и корректируем тренировку
        exercisesData?.removeAll(where: { exercise in
            var result = false
            for delEx in exercisesToDelete {
                if exercise.title == delEx.title{
                    result = true
                    break
                }
            }
            return result
        })
        exercisesToDelete.removeAll()
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
