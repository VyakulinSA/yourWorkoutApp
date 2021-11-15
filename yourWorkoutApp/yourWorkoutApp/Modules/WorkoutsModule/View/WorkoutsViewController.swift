//
//  WorkoutsViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 29.10.2021.
//

import UIKit

class WorkoutsViewController: YWMainContainerViewController, WorkoutsViewInput {
    
    var presenter: WorkoutsViewOutput
    
    init(presenter: WorkoutsViewOutput){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.getWorkoutsData()
        collectionView.reloadData()
    }

}

extension WorkoutsViewController {
    
    private func configViews() {
        collectionView.register(WorkoutsCollectionViewCell.self, forCellWithReuseIdentifier: WorkoutsCollectionViewCell.reuseIdentifier)
        
        setupNavBarItems(leftBarButtonName: .burger, firstRightBarButtonName: nil, secondRightBarButtonName: .plus, titleBarText: "WORKOUTS")
        
        leftBarButton.addTarget(self, action: #selector(startMenuButtonTapped), for: .touchUpInside)
        secondRightBarButton.addTarget(self, action: #selector(addBarButtonTapped), for: .touchUpInside)
    }
    
    @objc func startMenuButtonTapped() {
        presenter.startMenuButtonTapped()
    }
    
    @objc func addBarButtonTapped() {
        presenter.addBarButtonTapped()
    }
}

//MARK: Configure Collection
extension WorkoutsViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.workoutsData?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutsCollectionViewCell.reuseIdentifier, for: indexPath) as? WorkoutsCollectionViewCell else {return UICollectionViewCell()}
        
        if let workout = presenter.workoutsData?[indexPath.item] {
            cell.setupCellItems(
                workoutTitle: workout.title,
                exercisesCount: workout.exercises.count,
                muscleGroups: workout.muscleGroups,
                systemTagIsHidden: !workout.system
            )
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 145)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(item: indexPath.item)
    }
    
}
