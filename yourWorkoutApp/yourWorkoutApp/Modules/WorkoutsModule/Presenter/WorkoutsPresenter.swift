//
//  WorkoutsModule.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 29.10.2021.
//

import Foundation
import UIKit

protocol WorkoutsViewInput: AnyObject {
    
}

protocol WorkoutsViewOutput: AnyObject {
    
    var workoutsData: [Workout]? {get set}
    
    func startMenuButtonTapped()
    func addBarButtonTapped()
    func didSelectItem(item: Int)
    
}

class WorkoutsPresenter: WorkoutsViewOutput {
    var workoutsData: [Workout]?
    private var router: RouterConfiguratorProtocol
    
    init(router: RouterConfiguratorProtocol){
        self.router = router
        
        getWorkoutsData()
    }
}

extension WorkoutsPresenter {
    
    func startMenuButtonTapped() {
        router.initialViewController()
    }
    
    func addBarButtonTapped() {
        router.showEditCreateWorkoutViewController(editCreateType: .create, exercisesData: nil)
    }
    
    func didSelectItem(item: Int) {
        guard let workoutsData = workoutsData else {return}
        router.showWorkoutDetailViewController(exercisesData: nil, workout: workoutsData[item])
    }
    
    private func getWorkoutsData() {
        workoutsData = [
            Workout(title: "Home workout", countExercise: 5, muscleGroup: [.back, .biceps, .legs, .chest, .shoulders], system: true, exercises: nil),
            Workout(title: "Gyme workout", countExercise: 8, muscleGroup: [.back, .biceps, .legs, .chest, .shoulders, .abs, .back, .wholeBody], system: true, exercises: nil),
            Workout(title: "Standart", countExercise: 3, muscleGroup: [.back, .biceps, .legs], system: false, exercises: nil),
            Workout(title: "Gold train", countExercise: 4, muscleGroup: [.back, .biceps, .legs, .chest], system: false, exercises: nil)
        ]
    }
}
