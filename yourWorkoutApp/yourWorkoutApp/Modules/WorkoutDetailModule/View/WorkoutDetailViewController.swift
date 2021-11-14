//
//  WorkoutDetailViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 02.11.2021.
//

import UIKit

class WorkoutDetailViewController: YWMainContainerViewController, WorkoutDetailViewInput {
    
    var presenter: WorkoutDetailViewOutput
    
    init(presenter: WorkoutDetailViewOutput){
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
        dataModel = presenter.exercisesData
        collectionView.reloadData()
        titleView.text = presenter.workout.title.uppercased()
    }
    
}

extension WorkoutDetailViewController {
    
    private func configViews() {
        dataModel = presenter.exercisesData
        
        let title = presenter.workout.title.uppercased()
        
        setupNavBarItems(leftBarButtonName: .backArrow, firstRightBarButtonName: .xmarSeal, secondRightBarButtonName: .gear, titleBarText: title)
        
        firstRightBarButton.normalColor = .red
        firstRightBarButton.setupAppearance(systemNameImage: .xmarSeal)
        
        leftBarButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        firstRightBarButton.addTarget(self, action: #selector(trashBarButtonTapped), for: .touchUpInside)
        secondRightBarButton.addTarget(self, action: #selector(gearBarButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func backBarButtonTapped() {
        presenter.backBarButtonTapped()
    }
    
    @objc func trashBarButtonTapped(){
        presenter.trashBarButtonTapped()
    }
    
    @objc func gearBarButtonTapped() {
        presenter.gearBarButtonTapped()
    }
}


//MARK: config collectionView
extension WorkoutDetailViewController {
    
     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.reuseIdentifier, for: indexPath) as? ExerciseCollectionViewCell else {return UICollectionViewCell()}
        
         if let exercise = presenter.exercisesData?[indexPath.item] {
            let image = presenter.getImagesFromExercise(imageName: exercise.startImageName)
            cell.setupCellItems(exerciseImage: image, exerciseTitle: exercise.title, muscleGroup: exercise.muscleGroup.rawValue)
        }
        return cell
     }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectExercise(item: indexPath.item)
    }
}
