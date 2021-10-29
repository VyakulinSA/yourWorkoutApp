//
//  YWNavigationViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 28.10.2021.
//

import UIKit

class YWNavigationViewController: UINavigationController {
    
    private let navBarView = setupObject(UIView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .red
    }
    
    private let leftBarButton = setupObject(YWIconButton(systemNameImage: "text.justifyleft")) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        setupAppearance()
    }

}

extension YWNavigationViewController {
    
    private func setupAppearance() {
        view.addSubview(navBarView)
        navBarView.addSubview(leftBarButton)
        
        navBarView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            size: CGSize(width: 0, height: 90)
        )
        
        NSLayoutConstraint.activate([
            leftBarButton.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
            leftBarButton.centerXAnchor.constraint(equalTo: navBarView.centerXAnchor),
        ])
        
    }
}
