//
//  EditCreateExerciseViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 04.11.2021.
//

import UIKit

class EditCreateExerciseViewController: YWExerciseContainerViewController {
    
    var presenter: EditCreateExerciseViewOutput
    
    init(presenter: EditCreateExerciseViewOutput){
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

}

extension EditCreateExerciseViewController {
    
    private func configViews() {
        let secondRightBarButtonName = presenter.editCreateType == .edit ? IconButtonNames.trash : nil
        setupNavBarItems(leftBarButtonName: .backArrow, firstRightBarButtonName: nil, secondRightBarButtonName: secondRightBarButtonName, titleBarText: "CREATE EXERCISE")
        
        leftBarButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        secondRightBarButton.addTarget(self, action: #selector(trashBarButtonTapped), for: .touchUpInside)
    }
    
    @objc func backBarButtonTapped() {
        presenter.backBarButtonTapped()
    }
    
    @objc func trashBarButtonTapped() {
        //FIXME: удаление будет происходить из presentera, напрямую из базы, данный функционал для теста, если буду дальше использовать, то сделать проверку по всем полям, а не только по названию
        guard let rootVC = navigationController?.viewControllers[0] as? ExercisesViewController else {return}
        rootVC.presenter.exercisesData?.removeAll(where: { exercise in
            exercise.title == presenter.exercise?.title
        })
        presenter.trashBarButtonTapped()
    }
    
}


//MARK: config collectionView for edit type
extension EditCreateExerciseViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if presenter.editCreateType == .create {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        } else {
            //edit type
            let identifier = CellSettings.allCases[indexPath.item].identifierCell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
            guard let exercise = presenter.exercise else {return cell}
            
            switch cell {
                //images
            case let cell as ExerciseImagesCollectionViewCell:
                cell.setupImagesData(startImageData: exercise.startImage, endImageData: exercise.endImage)
                return cell
                //muscle
            case let cell as ExerciseMuscleGroupCollectionViewCell:
                cell.titleTextField.text = exercise.muscleGroup.rawValue
                return cell
                //description
            case let cell as ExerciseDescriptionCollectionViewCell:
                if exercise.description.count > 0 {
                    cell.descriptionTextView.text = exercise.description
                    cell.descriptionTextView.textColor = .darkTextColor
                }
                return cell
                //title
            case let cell as ExerciseTitleCollectionViewCell:
                cell.titleTextField.text = exercise.title
                return cell
                
            default:
                return cell
            }
        }
    }
}
