//
//  ExerciseTitleCollectionViewCell.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 03.11.2021.
//

import UIKit

class ExerciseTitleCollectionViewCell: UICollectionViewCell {
    
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
        
        let attributes = [NSAttributedString.Key.font: UIFont.myFont(.myFontRegular, size: 18)]
        $0.attributedPlaceholder = NSAttributedString(string: "Title", attributes: attributes as [NSAttributedString.Key : Any])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension ExerciseTitleCollectionViewCell {
    
    private func setupAppearance() {
        
        addSubview(titleLabel)
        addSubview(titleTextField)
        
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
    }
}
