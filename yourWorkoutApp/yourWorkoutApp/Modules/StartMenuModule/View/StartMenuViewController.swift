//
//  StartMenuViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 28.10.2021.
//

import UIKit

class StartMenuViewController: UIViewController, StartMenuViewInput {
     
    private let screenImageView = setupObject(UIImageView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "startMenuImage")
        $0.contentMode = .scaleAspectFill
        $0.isUserInteractionEnabled = false
    }
    
    private let workoutButton = setupObject(UIButton(type: .system)) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Workouts", for: .normal)
        $0.setTitleColor(.lightTextColor, for: .normal)
        $0.titleLabel?.font = UIFont.myFont(.myFontBold, size: 28)
    }
    
    private let exerciseButton = setupObject(UIButton(type: .system)) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Exercises", for: .normal)
        $0.setTitleColor(.lightTextColor, for: .normal)
        $0.titleLabel?.font = UIFont.myFont(.myFontBold, size: 28)
    }
    
    private let stackView = setupObject(UIStackView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignment = .fill
        $0.axis = .vertical
        $0.spacing = 40
    }
    
    private var presenter: StartMenuViewOutput
    
    init(presenter: StartMenuViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StartMenuViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        configViews()
    }

}


extension StartMenuViewController {
    
    private func setupAppearance() {
        view.addSubview(screenImageView)
        
        stackView.addArrangedSubview(workoutButton)
        stackView.addArrangedSubview(exerciseButton)
        
        view.addSubview(stackView)
        
        screenImageView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor
        )
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configViews(){
        workoutButton.addTarget(self, action: #selector(workoutButtonTapped), for: .touchUpInside)
        exerciseButton.addTarget(self, action: #selector(exerciseButtonTapped), for: .touchUpInside)
    }
    
    @objc func workoutButtonTapped(){
        presenter.workoutsButtonTapped()
    }
    
    @objc func exerciseButtonTapped(){
        presenter.exercisesButtonTapped()
    }
}
