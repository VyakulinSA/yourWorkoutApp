//
//  YWMainContainerViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 28.10.2021.
//

import UIKit

class YWMainContainerViewController: UIViewController {
    
    var dataModel: [ExerciseModelProtocol]?
    
    private var leftBarButtonName: IconButtonNames?
    private var firstRightBarButtonName: IconButtonNames?
    private var secondRightBarButtonName: IconButtonNames?
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
    
    let firstRightBarButton = setupObject(YWIconButton()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    let secondRightBarButton = setupObject(YWIconButton()) {
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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = false
        collection.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseCollectionViewCell.reuseIdentifier)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
    }

}

//MARK: - configViews
extension YWMainContainerViewController {
    
    func setupNavBarItems(leftBarButtonName: IconButtonNames?, firstRightBarButtonName: IconButtonNames?,
                        secondRightBarButtonName: IconButtonNames?, titleBarText: String) {
        self.leftBarButtonName = leftBarButtonName
        self.firstRightBarButtonName = firstRightBarButtonName
        self.secondRightBarButtonName = secondRightBarButtonName
        self.titleBarText = titleBarText
        configViews()
    }
    
    private func configViews() {
        leftBarButton.setupAppearance(systemNameImage: leftBarButtonName)
        firstRightBarButton.setupAppearance(systemNameImage: firstRightBarButtonName)
        secondRightBarButton.setupAppearance(systemNameImage: secondRightBarButtonName)
        titleView.text = titleBarText
    }
    
}

//MARK: - setupAppearance
extension YWMainContainerViewController {
    
    private func setupAppearance() {
        
        view.backgroundColor = .mainBackgroundColor
        
        view.addSubview(navBarView)
        view.addSubview(collectionView)
        
        navBarView.addSubview(leftBarButton)
        navBarView.addSubview(firstRightBarButton)
        navBarView.addSubview(secondRightBarButton)
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
        
        firstRightBarButton.anchor(
            top: nil,
            leading: nil,
            bottom: navBarView.bottomAnchor,
            trailing: secondRightBarButton.leadingAnchor,
            padding: UIEdgeInsets(top: 0, left: 0, bottom: 11, right: 8)
        )
        
        secondRightBarButton.anchor(
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
            trailing: secondRightBarButton.leadingAnchor,
            padding: UIEdgeInsets(top: 0, left: 10, bottom: 11, right: 10)
        )
        
        collectionView.anchor(
            top: navBarView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 0)
        )
        
    }
    
}

extension YWMainContainerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.reuseIdentifier, for: indexPath) as? ExerciseCollectionViewCell
        guard let cell = cell else {return UICollectionViewCell()}
//        if let exercise = dataModel?[indexPath.item] {
////            cell.setupCellItems(exerciseImage: exercise.startImage, exerciseTitle: exercise.title, muscleGroup: exercise.muscleGroup.rawValue)
//        }
        return cell
    }
}

extension YWMainContainerViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

