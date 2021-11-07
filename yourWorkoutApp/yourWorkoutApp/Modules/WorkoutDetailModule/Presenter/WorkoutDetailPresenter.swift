//
//  WorkoutDetailPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 02.11.2021.
//

import Foundation


protocol WorkoutDetailViewInput: AnyObject {
    
}

protocol WorkoutDetailViewOutput: AnyObject {
    var exercisesData: [ExerciseModelProtocol]? {get set}
    var workout: WorkoutModelProtocol {get set}
    
    func backBarButtonTapped()
    func gearBarButtonTapped()
    func trashBarButtonTapped()
}

class WorkoutDetailPresenter: WorkoutDetailViewOutput {
    private var router: RouterForWorkoutDetailModule
    var exercisesData: [ExerciseModelProtocol]?
    var workout: WorkoutModelProtocol
    
    init(router: RouterForWorkoutDetailModule, workout: WorkoutModelProtocol){
        self.router = router
        self.exercisesData = workout.exercises
        self.workout = workout
        getExercisesData()
    }
    
}

extension WorkoutDetailPresenter {
    
    func backBarButtonTapped() {
        router.popVC()
    }
    
    func gearBarButtonTapped() {
        router.showEditCreateWorkoutViewController(editCreateType: .edit, exercisesData: exercisesData)
    }
    
    func trashBarButtonTapped() {
        //удалить тренировку из БД
        router.popToRoot()
    }
    
    private func getExercisesData() {
    }
    
}
