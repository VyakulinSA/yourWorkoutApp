//
//  AddExerciseViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 02.11.2021.
//

import UIKit

class AddExerciseViewController: YWMainContainerViewController, AddExerciseViewInput {
    
    var presenter: AddExerciseViewOutput
    
    init(presenter: AddExerciseViewOutput){
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

extension AddExerciseViewController {
    
    private func configViews() {
        dataModel = presenter.exercisesData
        
        setupNavBarItems(leftBarButtonName: .backArrow, firstRightBarButtonName: nil, secondRightBarButtonName: .filter, titleBarText: "ADD TO WORKOUT")
        
        leftBarButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        secondRightBarButton.addTarget(self, action: #selector(filterBarButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func backBarButtonTapped() {
        presenter.backBarButtonTapped()
    }
    
    @objc func filterBarButtonTapped() {
        presenter.filterBarButtonTapped()
    }
    
    @objc func detailButtonTapped(sender: UIButton) {
        presenter.detailButtonTapped(item: sender.tag)
    }
    
    func reloadCollection() {
        dataModel = presenter.exercisesData
        collectionView.reloadData()
        print("AddExerciseViewController wilAppear reload")
    }
}

//MARK: config collectionView
extension AddExerciseViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.reuseIdentifier, for: indexPath) as? ExerciseCollectionViewCell else {return UICollectionViewCell()}

        if let exercise = presenter.exercisesData?[indexPath.item] {
            let image = presenter.getImagesFromExercise(imageName: exercise.startImageName)
            cell.setupCellItems(exerciseImage: image, exerciseTitle: exercise.title, muscleGroup: exercise.muscleGroup.rawValue)
            cell.detailButton.isHidden = false
            cell.detailButton.tag = indexPath.item
            cell.detailButton.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectCell(item: indexPath.item)
    }
}
