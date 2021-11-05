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
    
    lazy var addButton = setupObject(YWIconButton(systemNameImage: .circlePlus)) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .center
        let config = UIImage.SymbolConfiguration(pointSize: 50)
        $0.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        $0.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        addButton.isHidden = true
        exerciseImage.isHidden = false
        exerciseTitleLabel.isHidden = false
        muscleGroupLabel.isHidden = false
        
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
    }
}


extension ExerciseCollectionViewCell {
    
    func setupCellItems(exerciseImage: Data?, exerciseTitle: String, muscleGroup: String){
        if let exerciseImage = exerciseImage {
            self.exerciseImage.image = UIImage(data: exerciseImage)
        } else {
            self.exerciseImage.image = UIImage(named: "testExerciseImage")
        }
        self.exerciseTitleLabel.text = exerciseTitle
        self.muscleGroupLabel.text = muscleGroup
    }
    
    func setupAddButton(){
        contentView.addSubview(addButton)
        
        addButton.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor
        )
        
        exerciseImage.isHidden = true
        exerciseTitleLabel.isHidden = true
        muscleGroupLabel.isHidden = true
        addButton.isHidden = false
    }
    
    private func setupAppearance() {
        
        layer.cornerRadius = 20
        
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
