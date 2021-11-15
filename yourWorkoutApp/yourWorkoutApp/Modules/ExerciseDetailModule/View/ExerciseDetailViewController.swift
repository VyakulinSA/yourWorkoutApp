//
//  ExerciseDetailViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 04.11.2021.
//

import UIKit

class ExerciseDetailViewController: YWExerciseContainerViewController {
    
    var presenter: ExerciseDetailViewOutput
    
    init(presenter: ExerciseDetailViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getActualExercise()
        presenter.getImagesFromExercise()
        collectionView.reloadData()
    }
}

extension ExerciseDetailViewController {
    private func configViews() {
        let secondButton: IconButtonNames?  = presenter.editable ? .gear : nil
        setupNavBarItems(leftBarButtonName: .backArrow, firstRightBarButtonName: nil, secondRightBarButtonName: secondButton, titleBarText: "EXERCISE DETAIL")
        
        leftBarButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        
        guard presenter.editable else {return}
        secondRightBarButton.addTarget(self, action: #selector(editBarButtonTapped), for: .touchUpInside)
    }
    
    @objc func backBarButtonTapped() {
        presenter.backBarButtonTapped()
    }
    
    @objc func editBarButtonTapped() {
        presenter.editButtonTapped()
    }
}

//MARK: config collectionView
extension ExerciseDetailViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = CellSettings.allCases[indexPath.item].identifierCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        switch cell {
        case let cell as ExerciseImagesCollectionViewCell:
            return configureImages(cell: cell)
        case let cell as ExerciseMuscleGroupCollectionViewCell:
            return configureMuscleGroup(cell: cell)
        case let cell as ExerciseDescriptionCollectionViewCell:
            return configureDescription(cell: cell)
        case let cell as ExerciseTitleCollectionViewCell:
            return configureTitle(cell: cell)
        default:
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = getCellSettings(item: indexPath.item).heightCell
        return CGSize(width: width, height: height)
    }
    
}

//MARK: configure cells
extension ExerciseDetailViewController {
    
    private func getCellSettings(item: Int) -> (identifierCell: String, heightCell: CGFloat) {
        return (identifierCell: CellSettings.allCases[item].identifierCell,
                heightCell: CellSettings.allCases[item].detailHeightCell)
    }
    
    private func configureImages(cell: ExerciseImagesCollectionViewCell) -> UICollectionViewCell {
        cell.setupImagesData(startImage: presenter.startExerciseImage, endImage: presenter.endExerciseImage)
        return cell
    }
    
    private func configureMuscleGroup(cell: ExerciseMuscleGroupCollectionViewCell) -> UICollectionViewCell {
        cell.chevronImage.isHidden = true
        cell.titleTextField.isHidden = true
        cell.titleLabel.font = UIFont.myFont(.myFontSemiBold, size: 20)
        cell.titleLabel.textColor = .darkTextColor.withAlphaComponent(0.3)
        cell.detailMuscleGroupView.isHidden = false
        cell.detailMuscleGroupView.setupCellItems(muscleGroup: presenter.exercise.muscleGroup)
        return cell
    }
    
    private func configureDescription(cell: ExerciseDescriptionCollectionViewCell) -> UICollectionViewCell {
        cell.titleLabel.font = UIFont.myFont(.myFontSemiBold, size: 20)
        cell.titleLabel.textColor = .darkTextColor.withAlphaComponent(0.3)
        cell.descriptionTextView.text = presenter.exercise.description
        cell.descriptionTextView.backgroundColor = .clear
        cell.descriptionTextView.layer.borderWidth = 0
        cell.descriptionTextView.font = UIFont.myFont(.myFontSemiBold, size: 20)
        cell.descriptionTextView.textColor = .darkTextColor
        cell.descriptionTextView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        cell.descriptionTextView.layer.cornerRadius = 0
        return cell
    }
    
    private func configureTitle(cell: ExerciseTitleCollectionViewCell) -> UICollectionViewCell {
        cell.titleTextField.isHidden = true
        cell.titleLabel.isHidden = true
        cell.detailTitleLabel.text = presenter.exercise.title
        cell.detailTitleLabel.isHidden = false
        return cell
    }
}
