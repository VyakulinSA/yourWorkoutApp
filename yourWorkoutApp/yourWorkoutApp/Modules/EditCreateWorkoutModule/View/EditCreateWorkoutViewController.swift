//
//  EditCreateWorkoutViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import UIKit
import SwiftUI

class EditCreateWorkoutViewController: YWMainContainerViewController, EditCreateWorkoutViewInput {
    
    private var presenter: EditCreateWorkoutViewOutput
    
    init(presenter: EditCreateWorkoutViewOutput){
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

extension EditCreateWorkoutViewController {
    
    private func configViews() {
        if presenter.editCreateType == .create {
            setupNavBarItems(leftBarButtonName: .backArrow, firstRightBarButtonName: .trash,
                             secondRightBarButtonName: .checkmarkSeal, titleBarText: "CREATE WORKOUT")
        } else {
            setupNavBarItems(leftBarButtonName: nil, firstRightBarButtonName: .trash,
                             secondRightBarButtonName: .checkmarkSeal, titleBarText: "EDIT WORKOUT")
        }
        
        firstRightBarButton.isHidden = true
        firstRightBarButton.normalColor = .red
        firstRightBarButton.setupAppearance(systemNameImage: .trash)
        
        leftBarButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        firstRightBarButton.addTarget(self, action: #selector(trashBarButtonTapped), for: .touchUpInside)
        secondRightBarButton.addTarget(self, action: #selector(saveBarButtonTapped), for: .touchUpInside)
    }
    
    @objc func backBarButtonTapped() {
        presenter.backBarButtonTapped()
    }
    
    @objc func trashBarButtonTapped() {
        presenter.trashBarButtonTapped()
        firstRightBarButton.isHidden = true
    }
    
    @objc func saveBarButtonTapped() {
        presenter.saveBarButtonTapped()
    }
    
    @objc func addButtonTapped() {
        presenter.addBarButtonTapped()
    }
    
    func reloadCollection() {
        collectionView.reloadData()
        print("EditCreateWorkoutViewController wilAppear reload")
    }
}

//MARK: configure collection
extension EditCreateWorkoutViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (presenter.exercisesData?.count ?? 0) + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.reuseIdentifier, for: indexPath) as? ExerciseCollectionViewCell
        
        guard let cell = cell else {return UICollectionViewCell()}
        
        //setup last cell with addButton
        if indexPath.item >= (presenter.exercisesData?.count ?? 0) {
            cell.setupAddButton()
            cell.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            return cell
        }
        
        //setup cell items for exercise
//        if let exercise = presenter.exercisesData?[indexPath.item] {
////            cell.setupCellItems(exerciseImage: exercise.startImage, exerciseTitle: exercise.title, muscleGroup: exercise.muscleGroup.rawValue)
//        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ExerciseCollectionViewCell else {return}
        configure(cell: cell, indexPath: indexPath)
    }
}


//MARK: configureCollectionCell
extension EditCreateWorkoutViewController {

    private func configure(cell: ExerciseCollectionViewCell, indexPath: IndexPath) {
        guard let selectedExercise = presenter.exercisesData?[indexPath.item] else {return}
        let contain = presenter.exercisesToDelete.contains { $0.title == selectedExercise.title }
        if contain {
            presenter.exercisesToDelete.removeAll { $0.title == selectedExercise.title }
            cell.layer.borderWidth = 0
            cell.layer.borderColor = UIColor.clear.cgColor
        } else {
            presenter.exercisesToDelete.append(selectedExercise)
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.red.cgColor
        }
        firstRightBarButton.isHidden = presenter.exercisesToDelete.count > 0 ? false : true
    }
}

