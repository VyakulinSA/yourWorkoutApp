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
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
    }
    
    private let muscleGroupLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontRegular, size: 14)
        $0.textColor = .darkTextColor
    }
    
    lazy var detailButton = setupObject(UIButton(type: .system)) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .center
        $0.setTitle("Details", for: .normal)
        $0.isHidden = true
    }
    
    
    lazy var addButton: YWIconButton?  = getAddButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        exerciseImage.image = UIImage(named: "defaultExerciseImage")
        addButton?.isHidden = true
        addButton = nil
        exerciseImage.isHidden = false
        exerciseTitleLabel.isHidden = false
        muscleGroupLabel.isHidden = false
        detailButton.isHidden = true
        backgroundColor = .clear
        
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
    }
}


extension ExerciseCollectionViewCell {
    
    func setupCellItems(exerciseImage: UIImage?, exerciseTitle: String, muscleGroup: String){
        if let exerciseImage = exerciseImage {
            self.exerciseImage.image = exerciseImage
        } else {
            self.exerciseImage.image = UIImage(named: "defaultExerciseImage")
        }
        self.exerciseTitleLabel.text = exerciseTitle
        self.muscleGroupLabel.text = muscleGroup
    }
    
    func setupCellItems(leagueImage: UIImage?, leagueAbbr: String, leagueName: String){
        if let leagueImage = leagueImage {
            self.exerciseImage.image = leagueImage
            self.exerciseImage.contentMode = .scaleAspectFit
        } else {
            self.exerciseImage.image = UIImage(named: "defaultExerciseImage")
        }
        self.exerciseTitleLabel.text = leagueAbbr
        self.muscleGroupLabel.text = leagueName
    }
    
    func setupAddButton(){
        if addButton == nil {
            addButton = getAddButton()
        }
        contentView.addSubview(addButton!)
        
        addButton!.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor
        )
        
        exerciseImage.isHidden = true
        exerciseTitleLabel.isHidden = true
        muscleGroupLabel.isHidden = true
        addButton!.isHidden = false
    }
    
    private func getAddButton() -> YWIconButton {
        return setupObject(YWIconButton(systemNameImage: .circlePlus)) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentMode = .center
            let config = UIImage.SymbolConfiguration(pointSize: 50)
            $0.setPreferredSymbolConfiguration(config, forImageIn: .normal)
            $0.isHidden = true
        }
    }
    
    private func setupAppearance() {
        
        layer.cornerRadius = 20
        
        contentView.addSubview(exerciseImage)
        contentView.addSubview(exerciseTitleLabel)
        contentView.addSubview(detailButton)
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
            trailing: detailButton.leadingAnchor,
            padding: UIEdgeInsets(top: 15, left: 31, bottom: 0, right: 5)
        )
        
        muscleGroupLabel.anchor(
            top: exerciseTitleLabel.bottomAnchor,
            leading: exerciseTitleLabel.leadingAnchor,
            bottom: nil,
            trailing: exerciseTitleLabel.trailingAnchor,
            padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        )
        
        detailButton.anchor(
            top: contentView.topAnchor,
            leading: nil,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            size: CGSize(width: 55, height: 0)
        )
        
    }
}
