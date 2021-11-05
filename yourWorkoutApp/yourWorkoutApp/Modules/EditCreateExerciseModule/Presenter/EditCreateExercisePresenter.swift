//
//  EditCreateExercisePresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 04.11.2021.
//

import Foundation
enum EditCreateExerciseType {
    case edit
    case create
}

protocol EditCreateExerciseViewInput: AnyObject {
    
}

protocol EditCreateExerciseViewOutput: AnyObject {
    var exercise: Exercise? {get set}
    var editCreateType: EditCreateExerciseType {get set}
    
    func backBarButtonTapped()
    func trashBarButtonTapped()
    
}

class EditCreateExercisePresenter: EditCreateExerciseViewOutput {
    var editCreateType: EditCreateExerciseType
    var exercise: Exercise?
    private var router: RouterForEditCreateExerciseModule
    
    init(router: RouterForEditCreateExerciseModule, editCreateType: EditCreateExerciseType, exercise: Exercise?) {
        self.router = router
        self.editCreateType = editCreateType
        self.exercise = exercise
        getExercise()
    }
    
}

extension EditCreateExercisePresenter {
    
    func backBarButtonTapped() {
        router.popVC()
    }
    
    func trashBarButtonTapped() {
        //Удалить прям из базы упражнение, чтобы на главном контроллере получить все заново и перезагрузить коллекцию
        router.popToRoot()
    }
    
    private func getExercise() {
        
    }
}
