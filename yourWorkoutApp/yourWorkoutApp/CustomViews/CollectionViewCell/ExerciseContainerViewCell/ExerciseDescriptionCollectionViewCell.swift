//
//  ExerciseDescriptionCollectionViewCell.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 04.11.2021.
//

import UIKit

class ExerciseDescriptionCollectionViewCell: ExerciseTitleCollectionViewCell {
    
    let descriptionTextView = setupObject(UITextView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .inputViewsColor
        $0.text = "Start here..."
        $0.textColor = .lightGray
        $0.font = UIFont.myFont(.myFontRegular, size: 18)
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        $0.isScrollEnabled = true
        $0.isUserInteractionEnabled = true
        $0.isEditable = true
        
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.outlineColor.withAlphaComponent(0.6).cgColor
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


extension ExerciseDescriptionCollectionViewCell {
    
    private func configViews() {
        titleLabel.text = "Description"
        titleTextField.isHidden = true
        
        descriptionTextView.delegate = self
    }
    
    private func setupAppearance() {
        
        addSubview(descriptionTextView)
        
        descriptionTextView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20)
        )
        
    }
}

extension ExerciseDescriptionCollectionViewCell : UITextViewDelegate{
//    func textViewDidChange(_ textView: UITextView) {
//        presenter.settingsTransactionTouple.note = textView.text
//    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray || textView.text == "Start here..." {
            textView.text = nil
            textView.textColor = .darkTextColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Start here..."
            textView.textColor = .lightGray
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 250
    }
}
