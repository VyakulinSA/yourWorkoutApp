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
    var startExerciseImage: UIImage? {get set}
    var endExerciseImage: UIImage? {get set}
    
    var exercise: ExerciseModelProtocol {get set}
    var editCreateType: EditCreateExerciseType {get set}
    
    func backBarButtonTapped()
    func trashBarButtonTapped()
    
    func addImageButtonTapped(item: Int)
    
}

class EditCreateExercisePresenter: EditCreateExerciseViewOutput {
    var startExerciseImage: UIImage?
    var endExerciseImage: UIImage?
    
    var editCreateType: EditCreateExerciseType
    var noUpdatedExercise : ExerciseModelProtocol!
    var exercise: ExerciseModelProtocol
    weak var view: EditCreateExerciseViewInput?
    
    private var router: RouterForEditCreateExerciseModule
    private var exerciseStorageManager: DataStorageExerciseManagerProtocol
    private var imagesStorageManager: ImagesStorageManagerProtocol
    
    private var changeStartImage = false
    private var changeEndImage = false
    private var deletExercise = false
    
    init(exerciseStorageManager: DataStorageExerciseManagerProtocol, imagesStorageManager: ImagesStorageManagerProtocol, router: RouterForEditCreateExerciseModule, editCreateType: EditCreateExerciseType, exercise: ExerciseModelProtocol?) {
        self.router = router
        self.exerciseStorageManager = exerciseStorageManager
        self.imagesStorageManager = imagesStorageManager
        self.editCreateType = editCreateType
        
        if let exercise = exercise {
            self.exercise = exercise
        } else {
            self.exercise = ExerciseModel(title: "", muscleGroup: .wholeBody, description: "", startImageName: nil, endImageName: nil, id: UUID())
        }
        noUpdatedExercise = self.exercise
        getImagesFromExercise()
    }
}

//MARK: buttons action
extension EditCreateExercisePresenter {
    
    func backBarButtonTapped() {
        if (!changeStartImage && !changeEndImage)  && compare(lhs: exercise, rhs: noUpdatedExercise) {
            router.popVC(true)
            return
        }
    
        switch editCreateType {
        case .edit:
            router.showActionsForChangesAlert(output: self, acceptTitle: "Accept change", deleteTitle: "No", titleString: "Change exercise?")
        case .create:
            router.showActionsForChangesAlert(output: self, acceptTitle: "Add", deleteTitle: "No", titleString: "Add new Exercise?")
        }
    }
    
    func trashBarButtonTapped() {
        deletExercise = true
        router.showActionsForChangesAlert(output: self, acceptTitle: "Delete", deleteTitle: nil, titleString: "Delete exercisw?")
    }
    
    func addImageButtonTapped(item: Int) {
        router.showSelectExerciseImageActionsheet(output: self, selectedImageCell: SelectedImageCell.allCases[item])
    }
}

//MARK: private helpers funcs
extension EditCreateExercisePresenter {
    private func compare(lhs: ExerciseModelProtocol, rhs: ExerciseModelProtocol) -> Bool {
        guard lhs.title == rhs.title && lhs.muscleGroup == rhs.muscleGroup &&
            lhs.description == rhs.description && lhs.startImageName == rhs.startImageName &&
            lhs.endImageName == lhs.endImageName else { return false}
        return true
    }
    
    private func saveExerciseImagesWith(name: String) {
        if changeStartImage {
            exercise.startImageName = imagesStorageManager.save(image: startExerciseImage, with: String("\(name)_startImage"))
        }
        if changeEndImage {
            exercise.endImageName = imagesStorageManager.save(image: endExerciseImage, with: String("\(name)_endImage"))
        }
    }
    
    private func getImagesFromExercise() {
        startExerciseImage = imagesStorageManager.load(imageName: exercise.startImageName ?? "")
        endExerciseImage = imagesStorageManager.load(imageName: exercise.endImageName ?? "")
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
    
    func deletePhotoAction(selectedImageCell: SelectedImageCell?) {
        guard let selectedImageCell = selectedImageCell else {return}
        writeExerciseImages(image: nil, selectedCell: selectedImageCell)
    }
}

extension EditCreateExercisePresenter: SelectExerciseImagePickerOutput {
    
    func writeExerciseImages(image: UIImage?, selectedCell: SelectedImageCell) {
        switch selectedCell {
        case .start:
            startExerciseImage = image
            changeStartImage = true
        case .end:
            endExerciseImage = image
            changeEndImage = true
        }
        view?.reloadCollection()
    }
}

extension EditCreateExercisePresenter: ActionsForChangesAlertOutput {
    func accept() {
        if deletExercise {
            exerciseStorageManager.delete(exercise: exercise)
            router.popToRoot()
            return
        }
        
        if exercise.title.isEmpty {
            router.showMessageAlert(message: "Please enter the Title")
            return
        }
        
        saveExerciseImagesWith(name: "\(exercise.id)")
        
        switch editCreateType {
        case .edit:
            exerciseStorageManager.update(exercise: exercise)
        case .create:
            exerciseStorageManager.create(exercise: exercise)
        }
        
        router.popVC(true)
    }
    
    func deleteChanges() {
        router.popVC(true)
    }
}
