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
    
    var workoutsData: [WorkoutModelProtocol]? {get set}
    
    func startMenuButtonTapped()
    func addBarButtonTapped()
    func didSelectItem(item: Int)
    
    func getWorkoutsData()
    
}

class WorkoutsPresenter: WorkoutsViewOutput {
    var workoutsData: [WorkoutModelProtocol]?
    private var router: RouterForWorkoutsModule
    private var workoutStorageManager: DataStorageWorkoutManagerProtocol
    
    init(workoutStorageManager: DataStorageWorkoutManagerProtocol,router: RouterForWorkoutsModule){
        self.router = router
        self.workoutStorageManager = workoutStorageManager
        
        getWorkoutsData()
    }
}

extension WorkoutsPresenter {
    
    func startMenuButtonTapped() {
        router.initialViewController()
    }
    
    func addBarButtonTapped() {
        router.showEditCreateWorkoutViewController(editCreateType: .create, workout: nil)
    }
    
    func didSelectItem(item: Int) {
        guard let workoutsData = workoutsData else {return}
        router.showWorkoutDetailViewController(workout: workoutsData[item])
    }
    
    func getWorkoutsData() {
        workoutsData = workoutStorageManager.readAllWorkouts()
    }
}
