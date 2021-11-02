//
//  EditCreateWorkoutPresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import Foundation

enum EditCreateWorkoutType {
    case edit
    case create
}

protocol EditCreateWorkoutViewInput: AnyObject {
    
}

protocol EditCreateWorkoutViewOutput: AnyObject {
    var exercisesArray: [Exercise]? {get set}
    var editCreateType: EditCreateWorkoutType {get set}
    
    func leftBarButtonTapped()
    
}

class EditCreateWorkoutPresenter: EditCreateWorkoutViewOutput {
    var editCreateType: EditCreateWorkoutType
    var exercisesArray: [Exercise]?
    private var router: RouterConfiguratorProtocol
    
    init(router: RouterConfiguratorProtocol, editCreateType: EditCreateWorkoutType) {
        self.router = router
        self.editCreateType = editCreateType
    }
    
}

extension EditCreateWorkoutPresenter {
    
    func leftBarButtonTapped() {
        router.popVC()
    }
}
