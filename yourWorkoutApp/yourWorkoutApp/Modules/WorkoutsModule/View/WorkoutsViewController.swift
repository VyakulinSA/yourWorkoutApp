//
//  WorkoutsViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 29.10.2021.
//

import UIKit

class WorkoutsViewController: YWContainerViewController, WorkoutsViewInput {
    
    private var presenter: WorkoutsViewOutput
    
    init(presenter: WorkoutsViewOutput){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupAppearance()
        configViews()
    }
    

}

extension WorkoutsViewController {
    
    private func configViews() {
        collectionView.register(WorkoutsCollectionViewCell.self, forCellWithReuseIdentifier: WorkoutsCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        leftBarButton.addTarget(self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
        rightBarButton.addTarget(self, action: #selector(rightBarButtonTapped), for: .touchUpInside)
    }
    
    private func setupAppearance() {
        setupNavBarItems(leftBarButtonName: .burger, rightBarButtonName: .plus, titleBarText: "WORKOUTS")
    }
    
    @objc func leftBarButtonTapped() {
        presenter.startMenuButtonTapped()
    }
    
    @objc func rightBarButtonTapped() {
        print(#function)
    }
    
    
}

extension WorkoutsViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutsCollectionViewCell.reuseIdentifier, for: indexPath) as? WorkoutsCollectionViewCell
        guard let cell = cell else {return UICollectionViewCell()}
        cell.setupCellItems(workoutTitle: "Legs", exercisesCount: 5, muscleGroups: "Legs, Chest", systemTagIsHidden: false)
        return cell
    }
}

extension WorkoutsViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 145)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
