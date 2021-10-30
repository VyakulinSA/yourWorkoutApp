//
//  YWContainerViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 28.10.2021.
//

import UIKit

class YWContainerViewController: UIViewController {
    
    private var leftBarButtonName: IconButtonNames?
    private var rightBarButtonName: IconButtonNames?
    private var titleBarText: String?
     
    private let navBarView = setupObject(UIView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .mainBackgroundColor
        $0.layer.shadowColor = UIColor.outlineColor.cgColor
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    let leftBarButton = setupObject(YWIconButton()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    let rightBarButton = setupObject(YWIconButton()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private let titleView = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .myFont(.myFontBold, size: 16)
        $0.textColor = .darkTextColor
        $0.contentMode = .center
        $0.textAlignment = .center
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = false
        //register
        //delegate
        //dataSource
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
    }

}

//MARK: - configViews
extension YWContainerViewController {
    
    func setupNavBarItems(leftBarButtonName: IconButtonNames, rightBarButtonName: IconButtonNames, titleBarText: String) {
        self.leftBarButtonName = leftBarButtonName
        self.rightBarButtonName = rightBarButtonName
        self.titleBarText = titleBarText
        configViews()
    }
    
    private func configViews() {
        leftBarButton.setupAppearance(systemNameImage: leftBarButtonName)
        rightBarButton.setupAppearance(systemNameImage: rightBarButtonName)
        titleView.text = titleBarText
    }
    
}

//MARK: - setupAppearance
extension YWContainerViewController {
    
    private func setupAppearance() {
        view.backgroundColor = .mainBackgroundColor
        
        view.addSubview(navBarView)
        view.addSubview(collectionView)
        
        navBarView.addSubview(leftBarButton)
        navBarView.addSubview(rightBarButton)
        navBarView.addSubview(titleView)
        
        navBarView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            size: CGSize(width: 0, height: 90)
        )
        
        leftBarButton.anchor(
            top: nil,
            leading: navBarView.leadingAnchor,
            bottom: navBarView.bottomAnchor,
            trailing: nil,
            padding: UIEdgeInsets(top: 0, left: 28, bottom: 11, right: 0)
        )
        
        rightBarButton.anchor(
            top: nil,
            leading: nil,
            bottom: navBarView.bottomAnchor,
            trailing: navBarView.trailingAnchor,
            padding: UIEdgeInsets(top: 0, left: 0, bottom: 11, right: 28)
        )
        
        titleView.anchor(
            top: nil,
            leading: leftBarButton.trailingAnchor,
            bottom: navBarView.bottomAnchor,
            trailing: rightBarButton.leadingAnchor,
            padding: UIEdgeInsets(top: 0, left: 10, bottom: 11, right: 10)
        )
        
        collectionView.anchor(
            top: navBarView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor)
        
    }
    
}
