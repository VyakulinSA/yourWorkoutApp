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
    
    func reloadCollection() {
        dataModel = presenter.exercisesData
        collectionView.reloadData()
    }
}
