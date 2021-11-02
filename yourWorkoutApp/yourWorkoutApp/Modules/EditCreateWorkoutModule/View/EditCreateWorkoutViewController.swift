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
        collectionView.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let title = presenter.editCreateType == .create ? "CREATE WORKOUT" : "EDIT WORKOUT"
        setupNavBarItems(leftBarButtonName: .backArrow, firstRightBarButtonName: nil, secondRightBarButtonName: nil, titleBarText: title)
        
        leftBarButton.addTarget(self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
    }
    
    @objc func leftBarButtonTapped() {
        presenter.leftBarButtonTapped()
    }
    
    @objc func addButtonTapped() {
        print(#function)
    }
}

extension EditCreateWorkoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (presenter.exercisesData?.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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

extension EditCreateWorkoutViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
}
