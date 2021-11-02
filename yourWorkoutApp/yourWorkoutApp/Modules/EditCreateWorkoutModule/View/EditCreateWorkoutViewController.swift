//
//  EditCreateWorkoutViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import UIKit
import SwiftUI

class EditCreateWorkoutViewController: YWContainerViewController, ExercisesViewInput {
    
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
            setupNavBarItems(leftBarButtonName: .backArrow, firstRightBarButtonName: nil,
                             secondRightBarButtonName: nil, titleBarText: "CREATE WORKOUT")
        } else {
            setupNavBarItems(leftBarButtonName: nil, firstRightBarButtonName: nil,
                             secondRightBarButtonName: .checkmarkSeal, titleBarText: "EDIT WORKOUT")
        }
        
        leftBarButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        secondRightBarButton.addTarget(self, action: #selector(saveBarButtonTapped), for: .touchUpInside)
    }
    
    @objc func backBarButtonTapped() {
        presenter.backBarButtonTapped()
    }
    
    @objc func saveBarButtonTapped() {
        presenter.saveBarButtonTapped()
    }
    
    @objc func addButtonTapped() {
        presenter.addButtonTapped()
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
        if let exercise = presenter.exercisesData?[indexPath.item] {
            cell.setupCellItems(exerciseImage: exercise.startImage, exerciseTitle: exercise.title, muscleGroup: exercise.muscleGroup.rawValue)
        }
        
        return cell
    }
}

