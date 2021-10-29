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
    
    var router: RouterConfiguratorProtocol {get set}
    
    func setupView(view: WorkoutsViewInput)
}

class WorkoutsPresenter: WorkoutsViewOutput {
    
    weak var view: WorkoutsViewInput?
    var router: RouterConfiguratorProtocol
    
    init(router: RouterConfiguratorProtocol){
        self.router = router
    }
}

extension WorkoutsPresenter {
    func setupView(view: WorkoutsViewInput) {
        self.view = view
    }
}
