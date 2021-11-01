//
//  StartMenuPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 28.10.2021.
//

import Foundation

protocol StartMenuViewInput: AnyObject {
    
}
 
protocol StartMenuViewOutput: AnyObject {
    
//    var router: RouterConfiguratorProtocol {get set}
    
    
//    func setupView(view: StartMenuViewInput)
    
    func workoutsButtonTapped()
    
    func exercisesButtonTapped()
}


class StartMenuPresenter: StartMenuViewOutput {
    
//    private weak var view: StartMenuViewInput?
    var router: RouterConfiguratorProtocol
    
    init(router: RouterConfiguratorProtocol){
        self.router = router
    }
}

extension StartMenuPresenter{
//    func setupView(view: StartMenuViewInput) {
//        self.view = view
//    }
    
    func workoutsButtonTapped() {
        router.showWorkoutsViewController()
    }
    
    func exercisesButtonTapped() {
        router.showExercisesViewController()
    }
}
