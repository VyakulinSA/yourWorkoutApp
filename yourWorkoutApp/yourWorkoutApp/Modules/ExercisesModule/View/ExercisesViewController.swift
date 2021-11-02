//
//  ExercisesViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import UIKit

class ExercisesViewController: YWContainerViewController, ExercisesViewInput {

    var presenter: ExercisesViewOutput
    
    init(presenter: ExercisesViewOutput){
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

extension ExercisesViewController {
    
    private func configViews() {
        collectionView.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupNavBarItems(leftBarButtonName: .burger, firstRightBarButtonName: .filter, secondRightBarButtonName: .plus, titleBarText: "EXERCISES")
        
        leftBarButton.addTarget(self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
        firstRightBarButton.addTarget(self, action: #selector(firstRightBarButtonTapped), for: .touchUpInside)
        secondRightBarButton.addTarget(self, action: #selector(secondRightBarButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func leftBarButtonTapped() {
        presenter.startMenuButtonTapped()
    }
    
    @objc func firstRightBarButtonTapped() {
        print(#function)
    }
    
    @objc func secondRightBarButtonTapped() {
        print(#function)
    }
}

extension ExercisesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.exercisesData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.reuseIdentifier, for: indexPath) as? ExerciseCollectionViewCell
        guard let cell = cell else {return UICollectionViewCell()}
        if let exercise = presenter.exercisesData?[indexPath.item] {
            cell.setupCellItems(exerciseImage: exercise.startImage, exerciseTitle: exercise.title, muscleGroup: exercise.muscleGroup.rawValue)
        }
        return cell
    }
}

extension ExercisesViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}



