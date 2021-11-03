//
//  YWExerciseContainerViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 03.11.2021.
//

import UIKit

private enum CellSettings: CaseIterable{
    case imagesCell
    case titleCell
    case muscleGroupCell
    case descriptionCell
    
    var identifierCell: String {
        switch self {
        case .imagesCell:
            return "imagesCell"
        case .titleCell:
            return "titleCell"
        case .muscleGroupCell:
            return "muscleGroupCell"
        case .descriptionCell:
            return "descriptionCell"
        }
    }
    
    var heightCell: CGFloat {
        switch self {
        case .imagesCell:
            return 250
        case .titleCell:
            return 90
        case .muscleGroupCell:
            return 90
        case .descriptionCell:
            return 150
        }
    }
}

class YWExerciseContainerViewController: YWMainContainerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }
}

extension YWExerciseContainerViewController {
    private func configViews() {
        collectionView.register(ExerciseImagesCollectionViewCell.self,
                                forCellWithReuseIdentifier: CellSettings.imagesCell.identifierCell)
        collectionView.register(ExerciseTitleCollectionViewCell.self,
                                forCellWithReuseIdentifier: CellSettings.titleCell.identifierCell)
        collectionView.register(ExerciseMuscleGroupCollectionViewCell.self,
                                forCellWithReuseIdentifier: CellSettings.muscleGroupCell.identifierCell)
        collectionView.register(ExerciseDescriptionCollectionViewCell.self,
                                forCellWithReuseIdentifier: CellSettings.descriptionCell.identifierCell)
    }
    
    private func getCellSettings(item: Int) -> (identifierCell: String, heightCell: CGFloat) {
        
        return (identifierCell: CellSettings.allCases[item].identifierCell,
                heightCell: CellSettings.allCases[item].heightCell)
        
    }
}

extension YWExerciseContainerViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CellSettings.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //FIXME: сделать через switch и тип ячейки
        if indexPath.item == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellSettings.imagesCell.identifierCell, for: indexPath) as? ExerciseImagesCollectionViewCell
            return cell!
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellSettings.titleCell.identifierCell, for: indexPath) as? ExerciseTitleCollectionViewCell
            return cell!
        } else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellSettings.muscleGroupCell.identifierCell, for: indexPath) as? ExerciseMuscleGroupCollectionViewCell
            return cell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellSettings.descriptionCell.identifierCell, for: indexPath) as? ExerciseDescriptionCollectionViewCell
            return cell!
        }

    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = getCellSettings(item: indexPath.item).heightCell
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}
