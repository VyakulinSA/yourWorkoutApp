//
//  SelectExerciseImageActionsheet.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 11.11.2021.
//

import Foundation
import UIKit

protocol SelectExerciseImageActionsheetOutput: AnyObject {
    func cameraAction(source: UIImagePickerController.SourceType, selectedImageCell: SelectedImageCell?)
    func photoAction(source: UIImagePickerController.SourceType, selectedImageCell: SelectedImageCell?)
    func deletePhotoAction(selectedImageCell: SelectedImageCell?)
}

class SelectExerciseImageActionsheet: UIAlertController  {
    
    private var output: SelectExerciseImageActionsheetOutput?
    private var selectedImageCell: SelectedImageCell?
    
    private let cameraIcon = UIImage(systemName: "camera")
    private let photoIcon = UIImage(systemName: "photo")
    private let trashIcon = UIImage(systemName: "trash")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //при появлении alert возникает сломанный constraint, ошибка програмная на стороне apple
        setupAppearance()
    }
    
    private func setupAppearance() {

        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            self?.output?.cameraAction(source: .camera, selectedImageCell: self?.selectedImageCell)
        }
        cameraAction.setValue(cameraIcon, forKey: "image")
        cameraAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let photoAction = UIAlertAction(title: "Photo", style: .default) { [weak self] _ in
            self?.output?.photoAction(source: .photoLibrary, selectedImageCell: self?.selectedImageCell)
        }
        photoAction.setValue(photoIcon, forKey: "image")
        photoAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let deletePhotoAction = UIAlertAction(title: "Delete Image", style: .default) { [weak self] _ in
            self?.output?.deletePhotoAction(selectedImageCell: self?.selectedImageCell)
        }
        deletePhotoAction.setValue(trashIcon, forKey: "image")
        deletePhotoAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        addAction(cameraAction)
        addAction(photoAction)
        addAction(deletePhotoAction)
        addAction(cancelAction)
    }
    
    func configure(output: SelectExerciseImageActionsheetOutput, selectedImageCell: SelectedImageCell){
        self.output = output
        self.selectedImageCell = selectedImageCell
    }
}
