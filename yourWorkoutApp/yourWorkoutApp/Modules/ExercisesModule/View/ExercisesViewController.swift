//
//  ExercisesViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import UIKit

class ExercisesViewController: YWMainContainerViewController, ExercisesViewInput {

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
        dataModel = presenter.exercisesData
        
        setupNavBarItems(leftBarButtonName: .burger, firstRightBarButtonName: .filter, secondRightBarButtonName: .plus, titleBarText: "EXERCISES")
        
        leftBarButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        firstRightBarButton.addTarget(self, action: #selector(filterBarButtonTapped), for: .touchUpInside)
        secondRightBarButton.addTarget(self, action: #selector(createBarButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func backBarButtonTapped() {
        presenter.startMenuButtonTapped()
    }
    
    @objc func filterBarButtonTapped() {
        presenter.filterBarButtonTapped()
    }
    
    @objc func createBarButtonTapped() {
        presenter.createBarButtonTapped()
    }
}
