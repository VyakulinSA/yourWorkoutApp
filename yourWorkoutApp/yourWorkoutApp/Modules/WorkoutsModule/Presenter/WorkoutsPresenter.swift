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
    
}

class WorkoutsPresenter: WorkoutsViewOutput {
    var workoutsData: [WorkoutModelProtocol]?
    private var router: RouterForWorkoutsModule
    
    init(router: RouterForWorkoutsModule){
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
        router.showWorkoutDetailViewController(workout: workoutsData[item])
    }
    
    private func getWorkoutsData() {

    }
}
