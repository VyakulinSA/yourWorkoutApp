//
//  YWMuscleGroupBageView.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 04.11.2021.
//

import UIKit

class YWMuscleGroupBageView: UIView {

    private let detailMuscleGroupLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontSemiBold, size: 14)
        $0.textColor = .darkTextColor
        $0.textAlignment = .center

        $0.backgroundColor = .unselectedBadgeColor
        
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension YWMuscleGroupBageView {
    
    func setupCellItems(muscleGroup: MuscleGroup) {
        detailMuscleGroupLabel.text = muscleGroup.rawValue
    }
    
    private func setupAppearance() {
        
        layer.shadowColor = UIColor.workoutCellShadowColor.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 2, height: 2)
        
        addSubview(detailMuscleGroupLabel)
        
        detailMuscleGroupLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor
        )
    }
}
