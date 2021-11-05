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
    
    var exercisesData: [Exercise]?
    
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
        exercisesData = [
            Exercise(title: "Whole Body", muscleGroup: .wholeBody, description: "Whole Body description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Back", muscleGroup: .back, description: "Back description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Biceps", muscleGroup: .biceps, description: "Biceps description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Chest", muscleGroup: .chest, description: "Chest description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Triceps", muscleGroup: .triceps, description: "Triceps description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Shoulders", muscleGroup: .shoulders, description: "Shoulders description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Abs", muscleGroup: .abs, description: "Abs description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Legs", muscleGroup: .legs, description: "Legs description", startImage: nil, endImage: nil, workout: nil),
        ]
    }
    
}
