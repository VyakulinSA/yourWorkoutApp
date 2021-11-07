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
    var exercisesData: [ExerciseModelProtocol]? {get set}
    var exercisesToDelete: [ExerciseModelProtocol] {get set}
    var editCreateType: EditCreateWorkoutType {get set}
    
    func backBarButtonTapped()
    func saveBarButtonTapped()
    func addBarButtonTapped()
    func trashBarButtonTapped()
    
}

class EditCreateWorkoutPresenter: EditCreateWorkoutViewOutput {
    var editCreateType: EditCreateWorkoutType
    var exercisesToDelete: [ExerciseModelProtocol] = [ExerciseModelProtocol]()
    var exercisesData: [ExerciseModelProtocol]? {
        didSet {
            view?.reloadCollection()
        }
    }
    
    weak var view: EditCreateWorkoutViewInput?
    
    private var router: RouterForEditCreateWorkoutModule
    
    
    init(router: RouterForEditCreateWorkoutModule, editCreateType: EditCreateWorkoutType, exercisesData: [ExerciseModelProtocol]?) {
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

    }
}
