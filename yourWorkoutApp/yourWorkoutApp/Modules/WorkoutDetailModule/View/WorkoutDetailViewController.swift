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
        
        setupNavBarItems(leftBarButtonName: .backArrow, firstRightBarButtonName: .trash, secondRightBarButtonName: .gear, titleBarText: title)
        
        leftBarButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        firstRightBarButton.addTarget(self, action: #selector(trashBarButtonTapped), for: .touchUpInside)
        secondRightBarButton.addTarget(self, action: #selector(gearBarButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func backBarButtonTapped() {
        presenter.backBarButtonTapped()
    }
    
    @objc func trashBarButtonTapped(){
        //FIXME: удаление будет происходить из presentera, напрямую из базы, данный функционал для теста, если буду дальше использовать, то сделать проверку по всем полям, а не только по названию
        guard let rootVC = navigationController?.viewControllers[0] as? WorkoutsViewController else {return}
        rootVC.presenter.workoutsData?.removeAll(where: { workout in
                workout.title == presenter.workout.title
        })
        presenter.trashBarButtonTapped()
    }
    
    @objc func gearBarButtonTapped() {
        presenter.gearBarButtonTapped()
    }
}
