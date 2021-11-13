//
//  ImageCollectionViewCell.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 03.11.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 2
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.textAlignment = .center
        $0.font = UIFont.myFont(.myFontSemiBold, size: 22)
        $0.textColor = .darkTextColor
    }
    
    private let addButton = setupObject(YWIconButton(systemNameImage: .circlePlus)) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .center
        let config = UIImage.SymbolConfiguration(pointSize: 40)
        $0.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        $0.isUserInteractionEnabled = false
    }
    
    private let exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageCollectionViewCell {
    
    func setupCellItems(title: String, image: UIImage?){
        titleLabel.text = title
        exerciseImageView.image = image

    }
    
    private func setupAppearance() {
        backgroundColor = .inputViewsColor
        
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.outlineColor.withAlphaComponent(0.6).cgColor
        clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(exerciseImageView)
        
        titleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: addButton.topAnchor,
            trailing: trailingAnchor,
            padding: UIEdgeInsets(top: 20, left: 7, bottom: 5, right: 7)
        )
        
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        exerciseImageView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor
        )
    }
}
