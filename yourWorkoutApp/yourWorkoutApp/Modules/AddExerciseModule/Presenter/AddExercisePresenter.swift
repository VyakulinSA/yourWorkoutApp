//
//  AddExercisePresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 02.11.2021.
//

import Foundation

protocol AddExerciseViewInput: AnyObject {
    
}

protocol AddExerciseViewOutput: AnyObject {
    var exercisesData: [Exercise]? {get set}
    
    func backBarButtonTapped()
    func filterBarButtonTapped()
}

class AddExercisePresenter: AddExerciseViewOutput {
    private var router: RouterConfiguratorProtocol
    var exercisesData: [Exercise]?
    
    init(router: RouterConfiguratorProtocol){
        self.router = router
    }
    
}

extension AddExercisePresenter {
    
    func backBarButtonTapped() {
        router.popVC()
    }
    
    func filterBarButtonTapped() {
        print(#function)
    }
    
}
