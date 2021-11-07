//
//  AddExercisePresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 02.11.2021.
//

import Foundation

protocol AddExerciseViewInput: AnyObject {
    func reloadCollection()
}

protocol AddExerciseViewOutput: FilterExerciseProtocol {
    
    func backBarButtonTapped()
}

class AddExercisePresenter: AddExerciseViewOutput {
    
    private var router: RouterForAddExerciseModule
    weak var view: AddExerciseViewInput?
    
    var exercisesData: [ExerciseModelProtocol]?
    
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
    
    init(router: RouterForAddExerciseModule){
        self.router = router
        getExercisesData()
    }
}

extension AddExercisePresenter {
    
    func backBarButtonTapped() {
        router.popVC()
    }
    
    func filterBarButtonTapped() {
        router.showFilterExerciseViewConteroller(delegate: self)
    }
    
    private func getExercisesData() {

    }
    
}
