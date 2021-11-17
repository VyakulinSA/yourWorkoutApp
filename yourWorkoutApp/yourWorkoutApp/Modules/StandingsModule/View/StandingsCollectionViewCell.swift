//
//  StandingsCollectionViewCell.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 17.11.2021.
//

import UIKit

class StandingsCollectionViewCell: UICollectionViewCell {
    
    private let exerciseImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    private let fullNameLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontBold, size: 24)
        $0.textColor = .darkTextColor
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
        $0.text = "fullNameLabel"
    }
    
    private let teamTitleLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontSemiBold, size: 14)
        $0.textColor = .darkTextColor
        $0.text = "teamTitleLabel"
    }
    
    let stackView = setupObject(UIStackView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 10
    }
    
    private let winsLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontRegular, size: 18)
        $0.textColor = .darkTextColor
        $0.text = "Wins: 100"
    }
    
    private let lossesLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontRegular, size: 18)
        $0.textColor = .darkTextColor
        $0.text = "Losses: 100"
    }
    
    private let rankLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.myFont(.myFontRegular, size: 18)
        $0.textColor = .darkTextColor
        $0.text = "Rank: 100"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        exerciseImage.image = UIImage(named: "defaultExerciseImage")
        exerciseImage.isHidden = false
        teamTitleLabel.isHidden = false
        fullNameLabel.isHidden = false
    }
}


extension StandingsCollectionViewCell {
    
    func setupCellItems(teamImage: UIImage?, teamAbbr: String, teamName: String, teamRank: Int?, teamWins: Int?, teamLosses: Int?){
        if let leagueImage = teamImage {
            self.exerciseImage.image = leagueImage
            self.exerciseImage.contentMode = .scaleAspectFit
        } else {
            self.exerciseImage.image = UIImage(named: "defaultExerciseImage")
        }
        self.teamTitleLabel.text = teamAbbr
        self.fullNameLabel.text = teamName
        self.rankLabel.text = "Rank: \(teamRank ?? 0)"
        self.winsLabel.text = "Wins: \(teamWins ?? 0)"
        self.lossesLabel.text = "Losses: \(teamLosses ?? 0)"
    }
    
    private func setupAppearance() {
        configLayer()

        contentView.addSubview(exerciseImage)
        contentView.addSubview(teamTitleLabel)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(rankLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(winsLabel)
        stackView.addArrangedSubview(lossesLabel)
        
        exerciseImage.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: nil,
            padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0),
            size: CGSize(width: 120, height: 0)
        )
        
        fullNameLabel.anchor(
            top: contentView.topAnchor,
            leading: exerciseImage.trailingAnchor,
            bottom: nil,
            trailing: contentView.trailingAnchor,
            padding: UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 20)
        )
        
        teamTitleLabel.anchor(
            top: fullNameLabel.bottomAnchor,
            leading: fullNameLabel.leadingAnchor,
            bottom: nil,
            trailing: fullNameLabel.trailingAnchor,
            padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        )
        
        rankLabel.anchor(
            top: teamTitleLabel.bottomAnchor,
            leading: teamTitleLabel.leadingAnchor,
            bottom: nil,
            trailing: teamTitleLabel.trailingAnchor,
            padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        )

        stackView.anchor(
            top: rankLabel.bottomAnchor,
            leading: rankLabel.leadingAnchor,
            bottom: nil,
            trailing: rankLabel.trailingAnchor,
            padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        )
        
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
}
