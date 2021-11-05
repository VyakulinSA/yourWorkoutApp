//
//  ExercisesPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import Foundation

protocol ExercisesViewInput: AnyObject {
    func reloadCollection()
    
}

protocol ExercisesViewOutput: FilterExerciseProtocol {
    func startMenuButtonTapped()
    func createBarButtonTapped()
    func didSelectCell(item: Int)
}

class ExercisesPresenter: ExercisesViewOutput {
    private var router: RouterForExerciseModule
    weak var view: ExercisesViewInput?
    
    var exercisesData: [Exercise]? {
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
    
    init(router: RouterForExerciseModule){
        self.router = router
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
    
    private func getExercisesData() {
        exercisesData = [
            Exercise(title: "Whole Body ex", muscleGroup: .wholeBody, description: "Whole Body description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Back ex ", muscleGroup: .back, description: "", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Biceps ex", muscleGroup: .biceps, description: "Biceps description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Chest ex", muscleGroup: .chest, description: "Chest description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Triceps ex", muscleGroup: .triceps, description: "Triceps description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Shoulders ex", muscleGroup: .shoulders, description: "", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Abs ex", muscleGroup: .abs, description: "Abs description", startImage: nil, endImage: nil, workout: nil),
            Exercise(title: "Legs ex", muscleGroup: .legs, description: "Legs description", startImage: nil, endImage: nil, workout: nil),
        ]
    }
}
