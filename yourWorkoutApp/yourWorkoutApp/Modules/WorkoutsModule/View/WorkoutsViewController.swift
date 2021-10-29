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
    }

}

extension WorkoutsViewController {
    private func setupAppearance(){
        setupNavBarItems(leftBarButtonName: .burger, rightBarButtonName: .plus, titleBarText: "WORKOUTS")
    }
}
