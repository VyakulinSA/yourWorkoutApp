//
//  WorkoutsCollectionViewCell.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 30.10.2021.
//

import UIKit

class WorkoutsCollectionViewCell: UICollectionViewCell {
    
    private let workoutTitleLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontSemiBold, size: 28)
        $0.textColor = .darkTextColor
    }
    
    private let systemTagLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontSemiBold, size: 13)
        $0.textColor = .darkTextColor
        $0.contentMode = .center
        $0.textAlignment = .center
        $0.text = "S"
        
        $0.heightAnchor.constraint(equalToConstant: 16).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        $0.layer.cornerRadius = 16 / 2
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.darkTextColor.cgColor
    }
    
    private let exercisesCountLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontSemiBold, size: 16)
        $0.textColor = .darkTextColor
    }
    
    private let muscleGroupTitleLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontSemiBold, size: 16)
        $0.textColor = .darkTextColor
        $0.text = "Muscle group:"
    }
    
    private let muscleGroupsLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontRegular, size: 14)
        $0.textColor = .darkTextColor
    }
    
    private let chevronImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.right"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 15).isActive = true
        image.heightAnchor.constraint(equalToConstant: 30).isActive = true
        image.tintColor = .iconNormalColor
        return image
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
}


extension WorkoutsCollectionViewCell {
    
    func setupCellItems(workoutTitle: String, exercisesCount: Int, muscleGroups: [MuscleGroup], systemTagIsHidden: Bool) {
        let muscleGroupString = createMuscleGroupString(muscleGroups: muscleGroups)
        self.workoutTitleLabel.text = workoutTitle
        self.exercisesCountLabel.text = "Exercises: \(exercisesCount)"
        self.muscleGroupsLabel.text = muscleGroupString
        self.systemTagLabel.isHidden = systemTagIsHidden
    }
    
    private func setupAppearance() {
        configLayer()
        
        contentView.addSubview(workoutTitleLabel)
        contentView.addSubview(systemTagLabel)
        contentView.addSubview(exercisesCountLabel)
        contentView.addSubview(muscleGroupTitleLabel)
        contentView.addSubview(muscleGroupsLabel)
        contentView.addSubview(chevronImage)
        
        workoutTitleLabel.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 20)
        )
        
        exercisesCountLabel.anchor(
            top: workoutTitleLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            bottom: nil,
            trailing: contentView.trailingAnchor,
            padding: UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 20)
        )
        
        muscleGroupTitleLabel.anchor(
            top: exercisesCountLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            bottom: nil,
            trailing: contentView.trailingAnchor,
            padding: UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 20)
        )
        
        muscleGroupsLabel.anchor(
            top: muscleGroupTitleLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            bottom: nil,
            trailing: contentView.trailingAnchor,
            padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        )
        
        systemTagLabel.anchor(
            top: nil,
            leading: workoutTitleLabel.trailingAnchor,
            bottom: workoutTitleLabel.centerYAnchor,
            trailing: nil
        )
        
        NSLayoutConstraint.activate([
            chevronImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21)
        ])
    }
    
    private func configLayer(){
        layer.cornerRadius = 20
        layer.borderColor = UIColor.outlineColor.cgColor
        layer.borderWidth = 1
        layer.shadowColor = UIColor.workoutCellShadowColor.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 1, height: 2)
    }
    
    private func createMuscleGroupString(muscleGroups: [MuscleGroup]) -> String {
        var muscleGroupString = ""
        muscleGroups.forEach { gr in
            muscleGroupString += "\(gr.rawValue), "
        }
        muscleGroupString.removeLast()
        muscleGroupString.removeLast()
        return muscleGroupString
    }
}
