//
//  FilterExerciseCollectionViewCell.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 04.11.2021.
//

import UIKit

class FilterExerciseCollectionViewCell: UICollectionViewCell {
    
    let cellLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontSemiBold, size: 22)
        $0.textColor = .darkTextColor
        $0.textAlignment = .center
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterExerciseCollectionViewCell {
    
    private func setupAppearance() {
        
        contentView.addSubview(cellLabel)
        
        cellLabel.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor)
        
        backgroundColor = .unselectedBadgeColor
        
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.workoutCellShadowColor.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 1.0
        
    }
}
