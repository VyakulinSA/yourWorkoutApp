//
//  ExerciseTitleCollectionViewCell.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 03.11.2021.
//

import UIKit

class ExerciseTitleCollectionViewCell: UICollectionViewCell {
    
    weak var remotePresenter: EditCreateExerciseViewOutput?
    
    let titleLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontSemiBold, size: 18)
        $0.textColor = .darkTextColor
        $0.text = "Title"
    }
    
    let titleTextField = setupObject(UITextField()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .inputViewsColor
        
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.outlineColor.withAlphaComponent(0.6).cgColor
        $0.clipsToBounds = true
        $0.textColor = .darkTextColor
        
        let attributes = [NSAttributedString.Key.font: UIFont.myFont(.myFontRegular, size: 18)]
        $0.attributedPlaceholder = NSAttributedString(string: "Title", attributes: attributes as [NSAttributedString.Key : Any])
    }
    
    let detailTitleLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontSemiBold, size: 24)
        $0.textColor = .darkTextColor
        $0.text = "Detail Title"
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

extension ExerciseTitleCollectionViewCell {
    
    private func configViews() {
        titleTextField.delegate = self
    }
    
    private func setupAppearance() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleTextField)
        contentView.addSubview(detailTitleLabel)
        
        titleTextField.setPaddingPoints(20)
        
        titleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: titleTextField.topAnchor,
            trailing: trailingAnchor,
            padding: UIEdgeInsets(top: 0, left: 20, bottom: 8, right: 20)
        )
        
        titleTextField.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20)
        )
        
        detailTitleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        )
    }
}

extension ExerciseTitleCollectionViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {return}
        remotePresenter?.exercise.title = text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 30
    }
}
