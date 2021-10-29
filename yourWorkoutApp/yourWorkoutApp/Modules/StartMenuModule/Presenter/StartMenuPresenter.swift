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
    func setupView(view: StartMenuViewInput)
}


class StartMenuPresenter: StartMenuViewOutput {
    private weak var view: StartMenuViewInput?

    func setupView(view: StartMenuViewInput) {
        self.view = view
    }
}
