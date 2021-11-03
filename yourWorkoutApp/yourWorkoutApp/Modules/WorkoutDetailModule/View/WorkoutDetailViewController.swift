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
    
}

extension WorkoutDetailViewController {
    
    private func configViews() {
        dataModel = presenter.exercisesData
        
        let title = presenter.workout.title.uppercased()
        
        setupNavBarItems(leftBarButtonName: .backArrow, firstRightBarButtonName: nil, secondRightBarButtonName: .gear, titleBarText: title)
        
        leftBarButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        secondRightBarButton.addTarget(self, action: #selector(gearBarButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func backBarButtonTapped() {
        presenter.backBarButtonTapped()
    }
    
    @objc func gearBarButtonTapped() {
        presenter.gearBarButtonTapped()
    }
}
