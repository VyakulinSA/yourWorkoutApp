//
//  ExerciseMuscleGroupCollectionViewCell.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 03.11.2021.
//

import UIKit

class ExerciseMuscleGroupCollectionViewCell: ExerciseTitleCollectionViewCell {
    
    private var elements = MuscleGroup.allCases.map{$0.rawValue}
    private var selectedElement: String?
    
    let chevronImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.down"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 20).isActive = true
        image.heightAnchor.constraint(equalToConstant: 20).isActive = true
        image.tintColor = .iconNormalColor
        return image
    }()
    
    let detailMuscleGroupView = setupObject(YWMuscleGroupBageView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppearance()
        configViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExerciseMuscleGroupCollectionViewCell {
    
    private func configViews() {
        titleTextField.delegate = self
        
        titleLabel.text = "Muscle group"
        titleTextField.placeholder = "Muscle group"
        
        choiceElement()
    }
    
    private func setupAppearance() {
        addSubview(chevronImage)
        addSubview(detailMuscleGroupView)
        
        
        NSLayoutConstraint.activate([
            chevronImage.centerYAnchor.constraint(equalTo: titleTextField.centerYAnchor),
            chevronImage.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor, constant: -18)
        ])
        
        detailMuscleGroupView.anchor(
            top: titleLabel.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0),
            size: CGSize(width: 100, height: 30))
    }
}

//config Pickerview in TextField
extension ExerciseMuscleGroupCollectionViewCell {
        
    private func choiceElement() {
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        titleTextField.inputView = elementPicker
    }
}

extension ExerciseMuscleGroupCollectionViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return elements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return elements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedElement = elements[row]
        titleTextField.text = selectedElement
    }
}

extension ExerciseMuscleGroupCollectionViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
