//
//  FilterExercisePresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 04.11.2021.
//

import Foundation

protocol FilterExerciseViewInput: AnyObject {
    
}

protocol FilterExerciseViewOutput: AnyObject {
    
}

class FilterExercisePresenter: FilterExerciseViewOutput {
    private var router: RouterConfiguratorProtocol
    
    init(router: RouterConfiguratorProtocol) {
        self.router = router
    }
    
}
