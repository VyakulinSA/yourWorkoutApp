//
//  ExerciseImagesCollectionViewCell.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 03.11.2021.
//

import UIKit

private enum ImagesCellSettings: CaseIterable {
    case startImage
    case endImage
    
    var title: String {
        switch self {
        case .startImage:
            return "Add Start Exercise Image"
        case .endImage:
            return "Add End Exercise Image"
        }
    }
    
    var cellHeight: CGFloat {
        return 250
    }
}

class ExerciseImagesCollectionViewCell: UICollectionViewCell {
    
    weak var remotePresenter: EditCreateExerciseViewOutput?
    
    private var startImage: UIImage?
    private var endImage: UIImage?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppearance()
        configViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExerciseImagesCollectionViewCell {
    
    func setupImagesData(startImage: UIImage?, endImage: UIImage?) {
        self.startImage = startImage
        self.endImage = endImage
        collectionView.reloadData()
    }
    
    private func configViews() {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupAppearance() {
        contentView.addSubview(collectionView)
        
        collectionView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor
        )
    }
}

extension ExerciseImagesCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImagesCellSettings.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {return UICollectionViewCell()}

        let imagesCellSettings = ImagesCellSettings.allCases[indexPath.item]
        
        let image =  imagesCellSettings == .startImage ? startImage : endImage
        
        cell.setupCellItems(title: imagesCellSettings.title, image: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        remotePresenter?.addImageButtonTapped(item: indexPath.item)
    }
    
}

extension ExerciseImagesCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ImagesCellSettings.startImage.cellHeight, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
