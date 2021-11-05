//
//  FilterExerciseViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 04.11.2021.
//

import UIKit

private enum ConfigureCell {
    case forCreate
    case forSelect
}

class FilterExerciseViewController: UIViewController {
    
    private var presenter: FilterExerciseViewOutput
    
    private let titleLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Filter Exercises"
        $0.font = UIFont.myFont(.myFontSemiBold, size: 22)
        $0.textColor = .darkTextColor
    }
    
    private let muscleGroupLabel = setupObject(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Muscle group"
        $0.font = UIFont.myFont(.myFontBold, size: 22)
        $0.textColor = .labelTextColor
    }
    
    lazy var muscleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.alwaysBounceVertical = false
        collection.register(FilterExerciseCollectionViewCell.self,
                            forCellWithReuseIdentifier: FilterExerciseCollectionViewCell.reuseIdentifier)
        
        collection.backgroundColor = .clear
        
        collection.delegate = self
        collection.dataSource = self
        
        return collection
    }()
    
    private let applyButton  = setupObject(UIButton(type: .system)) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .normalButtonColor
        $0.setTitle("Apply Filters", for: .normal)
        $0.titleLabel?.font = UIFont.myFont(.myFontBold, size: 24)
        $0.setTitleColor(.lightTextColor, for: .normal)
        $0.setTitleColor(.unselectedBadgeColor, for: .highlighted)
        
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor.workoutCellShadowColor.cgColor
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowRadius = 2
        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    init(presenter: FilterExerciseViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
        configViews()
    }

}

extension FilterExerciseViewController {
    
    private func configViews() {
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
    }
    
    private func setupAppearance() {
        
        view.backgroundColor = .mainBackgroundColor
        
        view.addSubview(titleLabel)
        view.addSubview(muscleGroupLabel)
        view.addSubview(applyButton)
        view.addSubview(muscleCollectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            applyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            applyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            applyButton.widthAnchor.constraint(equalToConstant: 300),
            applyButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        muscleGroupLabel.anchor(
            top: titleLabel.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: UIEdgeInsets(top: 60, left: 20, bottom: 0, right: 20)
        )
        
        muscleCollectionView.anchor(
            top: muscleGroupLabel.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: applyButton.topAnchor,
            trailing: view.trailingAnchor,
            padding: UIEdgeInsets(top: 30, left: 0, bottom: 20, right: 0)
        )
    }
    
    @objc func applyButtonTapped() {
        presenter.applyButtonTapped()
        dismiss(animated: true, completion: nil)
    }
}

extension FilterExerciseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MuscleGroup.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterExerciseCollectionViewCell.reuseIdentifier, for: indexPath) as? FilterExerciseCollectionViewCell
        
        guard var cell = cell else {return UICollectionViewCell()}
        
        cell.cellLabel.text = MuscleGroup.allCases[indexPath.item].rawValue
        cell = configure(cell: cell, indexPath: indexPath, for: .forCreate)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FilterExerciseCollectionViewCell else {return}
        let _ = configure(cell: cell, indexPath: indexPath, for: .forSelect)
    }
}


extension FilterExerciseViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 45
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 10, right: 30)
    }
    
}

//MARK: configureCollectionCell
extension FilterExerciseViewController {
    
    private func configure(cell: FilterExerciseCollectionViewCell, indexPath: IndexPath, for config: ConfigureCell) -> FilterExerciseCollectionViewCell {
        let muscle = MuscleGroup.allCases[indexPath.item]
        let contain = presenter.selectedFilterMuscleGroups.contains(muscle)

        switch config {
        case .forCreate:
            cell.backgroundColor = contain ? .selectedBadgeColor : .unselectedBadgeColor
            cell.cellLabel.textColor = contain ? .lightTextColor : .darkTextColor
        case .forSelect:
            cell.backgroundColor = contain ? .unselectedBadgeColor : .selectedBadgeColor
            cell.cellLabel.textColor = contain ? .darkTextColor : .lightTextColor
            
            if contain {
                presenter.selectedFilterMuscleGroups.removeAll { $0 == muscle }
            } else {
                presenter.selectedFilterMuscleGroups.append(MuscleGroup.allCases[indexPath.item])
            }
        }
        return cell
    }
}
