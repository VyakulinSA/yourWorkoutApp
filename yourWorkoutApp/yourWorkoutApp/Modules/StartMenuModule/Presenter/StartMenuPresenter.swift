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
    
    func workoutsButtonTapped()
    
    func exercisesButtonTapped()
    
    func leaguesButtonTapped()
}


class StartMenuPresenter: StartMenuViewOutput {

    private var router: RouterForStartMenuModule
    
    init(router: RouterForStartMenuModule){
        self.router = router
    }
}

extension StartMenuPresenter{
    
    func workoutsButtonTapped() {
        router.showWorkoutsViewController()
    }
    
    func exercisesButtonTapped() {
        router.showExercisesViewController()
    }
    
    func leaguesButtonTapped() {
        router.showLeaguesViewController()
    }
}
