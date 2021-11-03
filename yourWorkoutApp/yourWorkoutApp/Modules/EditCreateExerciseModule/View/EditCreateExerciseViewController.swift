//
//  EditCreateExerciseViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 04.11.2021.
//

import UIKit

class EditCreateExerciseViewController: YWExerciseContainerViewController {
    
    var presenter: EditCreateExerciseViewOutput
    
    init(presenter: EditCreateExerciseViewOutput){
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

extension EditCreateExerciseViewController {
    
    private func configViews() {
        setupNavBarItems(leftBarButtonName: .backArrow, firstRightBarButtonName: nil, secondRightBarButtonName: nil, titleBarText: "CREATE EXERCISE")
        
        leftBarButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
    }
    
    @objc func backBarButtonTapped() {
        presenter.backBarButtonTapped()
    }
    
}
