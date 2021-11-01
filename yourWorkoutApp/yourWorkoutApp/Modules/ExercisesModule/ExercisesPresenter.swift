//
//  ExercisesPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import Foundation

protocol ExercisesViewInput: AnyObject {
    
    
}

protocol ExercisesViewOutput: AnyObject {
    
//    var router: RouterConfiguratorProtocol {get set}
    
    func setupView(view: ExercisesViewInput)
    func startMenuButtonTapped()
    
}


class ExercisesPresenter: ExercisesViewOutput {
    
    private weak var view: ExercisesViewInput?
    var router: RouterConfiguratorProtocol
    
    init(router: RouterConfiguratorProtocol){
        self.router = router
    }
    
}

extension ExercisesPresenter {
    func setupView(view: ExercisesViewInput) {
        self.view = view
    }
    
    func startMenuButtonTapped() {
        router.initialViewController()
    }
}
