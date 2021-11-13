//
//  SelectExerciseImagePickerController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 11.11.2021.
//

import UIKit

protocol SelectExerciseImagePickerOutput: AnyObject {
    func writeExerciseImages(image: UIImage?, selectedCell: SelectedImageCell)
}

class SelectExerciseImagePicker: UIImagePickerController {
    
    private var source: UIImagePickerController.SourceType?
    private weak var output: SelectExerciseImagePickerOutput?
    private var selectedImageCell: SelectedImageCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func configure(output: SelectExerciseImagePickerOutput, selectedImageCell: SelectedImageCell){
        self.output = output
        self.selectedImageCell = selectedImageCell
    }
    
}

extension SelectExerciseImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.editedImage] as? UIImage
        guard let output = output, let selectedImageCell = selectedImageCell else {return}
        output.writeExerciseImages(image: selectedImage, selectedCell: selectedImageCell)
        dismiss(animated: true, completion: nil)
    }
}
