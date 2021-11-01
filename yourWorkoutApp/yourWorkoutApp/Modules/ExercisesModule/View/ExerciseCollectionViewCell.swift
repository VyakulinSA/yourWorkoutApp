//
//  ExerciseCollectionViewCell.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import UIKit

class ExerciseCollectionViewCell: UICollectionViewCell {
    
    private let exerciseImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.layer.borderColor = UIColor.unselectedBadgeColor.cgColor
        image.layer.borderWidth = 1
        image.clipsToBounds = true
        return image
    }()
    
    private let exerciseTitleLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontSemiBold, size: 24)
        $0.textColor = .darkTextColor
    }
    
    private let muscleGroupLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontRegular, size: 14)
        $0.textColor = .darkTextColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ExerciseCollectionViewCell {
    
    func setupCellItems(exerciseImage: UIImage?, exerciseTitle: String, muscleGroup: String){
        if let exerciseImage = exerciseImage {
            self.exerciseImage.image = exerciseImage
        } else {
            self.exerciseImage.image = UIImage(named: "testExerciseImage")
        }
        self.exerciseTitleLabel.text = exerciseTitle
        self.muscleGroupLabel.text = muscleGroup
    }
    
    private func setupAppearance() {
        
        contentView.addSubview(exerciseImage)
        contentView.addSubview(exerciseTitleLabel)
        contentView.addSubview(muscleGroupLabel)
        
        exerciseImage.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: nil,
            size: CGSize(width: 120, height: 0)
        )
        
        exerciseTitleLabel.anchor(
            top: contentView.topAnchor,
            leading: exerciseImage.trailingAnchor,
            bottom: nil,
            trailing: contentView.trailingAnchor,
            padding: UIEdgeInsets(top: 15, left: 31, bottom: 0, right: 31)
        )
        
        muscleGroupLabel.anchor(
            top: exerciseTitleLabel.bottomAnchor,
            leading: exerciseTitleLabel.leadingAnchor,
            bottom: nil,
            trailing: exerciseTitleLabel.trailingAnchor,
            padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        )
        
    }
}
