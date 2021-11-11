//
//  EditCreateExercisePresenter.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 04.11.2021.
//

import Foundation
import UIKit

enum EditCreateExerciseType {
    case edit
    case create
}

enum SelectedImageCell:CaseIterable {
    case start
    case end
}

protocol EditCreateExerciseViewInput: AnyObject {
    func reloadCollection()
}

protocol EditCreateExerciseViewOutput: AnyObject {
    var startExerciseImage: Data? {get set}
    var endExerciseImage: Data? {get set}
    
    var exercise: ExerciseModelProtocol? {get set}
    var editCreateType: EditCreateExerciseType {get set}
    
    func backBarButtonTapped()
    func trashBarButtonTapped()
    
    func addImageButtonTapped(item: Int)
    
}

class EditCreateExercisePresenter: EditCreateExerciseViewOutput {
    var startExerciseImage: Data?
    var endExerciseImage: Data?
    
    var editCreateType: EditCreateExerciseType
    var exercise: ExerciseModelProtocol?
    weak var view: EditCreateExerciseViewInput?
    private var router: RouterForEditCreateExerciseModule
    private var exerciseStorageManager: DataStorageExerciseManagerProtocol
    
    init(exerciseStorageManager: DataStorageExerciseManagerProtocol, router: RouterForEditCreateExerciseModule, editCreateType: EditCreateExerciseType, exercise: ExerciseModelProtocol?) {
        self.router = router
        self.editCreateType = editCreateType
        self.exercise = exercise
        self.exerciseStorageManager = exerciseStorageManager
        getImagesFromExercise()
    }
    
    private func getImagesFromExercise() {
//        guard let exercise = exercise else {return}
        //извлекаем изображение из документов и присваиваем свойствам презентера для изображений
    }
}

extension EditCreateExercisePresenter {
    
    func backBarButtonTapped() {
        //создаем упражнение
        //вызываем мэнеджер рабоыт с базой и сохраняем
        router.popVC()
    }
    
    func trashBarButtonTapped() {
        //Удалить прям из базы упражнение, чтобы на главном контроллере получить все заново и перезагрузить коллекцию
        router.popToRoot()
    }
    
    func addImageButtonTapped(item: Int) {
        router.showSelectExerciseImageActionsheet(output: self, selectedImageCell: SelectedImageCell.allCases[item])
    }
}

extension EditCreateExercisePresenter: SelectExerciseImageActionsheetOutput {
    func cameraAction(source: UIImagePickerController.SourceType, selectedImageCell: SelectedImageCell?) {
        guard let selectedImageCell = selectedImageCell else {return}
        router.showSelectExerciseImagePickerController(output: self, selectedImageCell: selectedImageCell, source: source)
    }
    
    func photoAction(source: UIImagePickerController.SourceType, selectedImageCell: SelectedImageCell?) {
        guard let selectedImageCell = selectedImageCell else {return}
        router.showSelectExerciseImagePickerController(output: self, selectedImageCell: selectedImageCell, source: source)
    }
}

extension EditCreateExercisePresenter: SelectExerciseImagePickerOutput {
    
    func writeExerciseImages(imageData: Data?, selectedCell: SelectedImageCell) {
        switch selectedCell {
        case .start:
            startExerciseImage = imageData
        case .end:
            endExerciseImage = imageData
        }
        view?.reloadCollection()
    }
}
