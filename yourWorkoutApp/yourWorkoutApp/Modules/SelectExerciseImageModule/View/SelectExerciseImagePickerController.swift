//
//  SelectExerciseImagePickerController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 11.11.2021.
//

import UIKit

protocol SelectExerciseImagePickerOutput: AnyObject {
    func writeExerciseImages(imageData: Data?, selectedCell: SelectedImageCell)
}

class SelectExerciseImagePickerController: UIImagePickerController {
    
    private var source: UIImagePickerController.SourceType?
    private weak var output: SelectExerciseImagePickerOutput?
    private var selectedImageCell: SelectedImageCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(output: SelectExerciseImagePickerOutput, selectedImageCell: SelectedImageCell){
        self.output = output
        self.selectedImageCell = selectedImageCell
    }
    
}

extension SelectExerciseImagePickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.editedImage] as? UIImage
        let imageData = selectedImage?.jpegData(compressionQuality: 1.0) ?? selectedImage?.pngData()
        guard let output = output, let selectedImageCell = selectedImageCell else {return}
        output.writeExerciseImages(imageData: imageData, selectedCell: selectedImageCell)
        dismiss(animated: true, completion: nil)
    }
}
