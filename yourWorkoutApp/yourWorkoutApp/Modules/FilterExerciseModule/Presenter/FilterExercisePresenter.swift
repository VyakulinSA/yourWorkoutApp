//
//  FilterExercisePresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 04.11.2021.
//

import Foundation

protocol FilterExerciseProtocol: AnyObject {
    var exercisesData: [ExerciseModelProtocol]? {get set}
    var selectedFilterMuscleGroups: [MuscleGroup]? {get set}
    
    func filterBarButtonTapped()
}

protocol FilterExerciseViewInput: AnyObject {
    
}

protocol FilterExerciseViewOutput: AnyObject {
    var selectedFilterMuscleGroups: [MuscleGroup] {get set}
    
    func applyButtonTapped()
}

class FilterExercisePresenter: FilterExerciseViewOutput {
    private var router: RouterForFilterExerciseModule
    
    var selectedFilterMuscleGroups: [MuscleGroup]
    weak var delegate: FilterExerciseProtocol?
    
    init(router: RouterForFilterExerciseModule, delegate: FilterExerciseProtocol) {
        self.router = router
        self.delegate = delegate
        selectedFilterMuscleGroups = delegate.selectedFilterMuscleGroups ?? [MuscleGroup]()
    }
    
}

extension FilterExercisePresenter {
    
    func applyButtonTapped() {
        delegate?.selectedFilterMuscleGroups = selectedFilterMuscleGroups
    }
}
