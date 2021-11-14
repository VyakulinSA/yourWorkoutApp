//
//  EditCreateWorkoutViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import UIKit
import SwiftUI

class EditCreateWorkoutViewController: YWMainContainerViewController, EditCreateWorkoutViewInput {
    
    private var presenter: EditCreateWorkoutViewOutput
    var tapScreen: UIGestureRecognizer?
    
    init(presenter: EditCreateWorkoutViewOutput){
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        secondRightBarButton.isEnabled = presenter.exercisesData.count > 0 ? true : false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        titleTextField.endEditing(true)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.collectionView.endEditing(true)
    }
}

extension EditCreateWorkoutViewController {
    
    private func configViews() {
        switch presenter.editCreateType {
        case .edit:
            leftBarButton.isHidden = true
            titleTextField.text = presenter.workout.title.uppercased()
            setupNavBarItems(leftBarButtonName: nil, firstRightBarButtonName: .trash,
                             secondRightBarButtonName: .checkmarkSeal, titleBarText: "EDIT WORKOUT")

        case .create:
            setupNavBarItems(leftBarButtonName: .backArrow, firstRightBarButtonName: .trash,
                             secondRightBarButtonName: .checkmarkSeal, titleBarText: "CREATE WORKOUT")
        }
        
        firstRightBarButton.isHidden = true
        firstRightBarButton.normalColor = .red
        firstRightBarButton.setupAppearance(systemNameImage: .trash)
        
        titleView.isHidden = true
        titleTextField.isHidden = false
        titleTextField.delegate = self
        
        leftBarButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        firstRightBarButton.addTarget(self, action: #selector(trashBarButtonTapped), for: .touchUpInside)
        secondRightBarButton.addTarget(self, action: #selector(saveBarButtonTapped), for: .touchUpInside)
    }
}

//MARK: configure collection
extension EditCreateWorkoutViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.exercisesData.count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.reuseIdentifier, for: indexPath) as? ExerciseCollectionViewCell else {return UICollectionViewCell()}
        
        //setup last cell with addButton
        if indexPath.item >= presenter.exercisesData.count {
            cell.setupAddButton()
            cell.addButton?.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            return cell
        }
        
        //setup cell items for exercise
        let exercise = presenter.exercisesData[indexPath.item]
        let image = presenter.getImagesFromExercise(imageName: exercise.startImageName)
        cell.setupCellItems(exerciseImage: image, exerciseTitle: exercise.title, muscleGroup: exercise.muscleGroup.rawValue)
        cell.detailButton.isHidden = false
        cell.detailButton.tag = indexPath.item
        cell.detailButton.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ExerciseCollectionViewCell else {return}
        configure(cell: cell, indexPath: indexPath)
    }
}


//MARK: configureCollectionCell
extension EditCreateWorkoutViewController {

    private func configure(cell: ExerciseCollectionViewCell, indexPath: IndexPath) {
        let selectedExercise = presenter.exercisesData[indexPath.item]
        let contain = presenter.exercisesToDelete.contains { $0.title == selectedExercise.title }
        if contain {
            presenter.exercisesToDelete.removeAll { $0.title == selectedExercise.title }
            cell.backgroundColor = .clear
            cell.layer.borderWidth = 0
            cell.layer.borderColor = UIColor.clear.cgColor
        } else {
            presenter.exercisesToDelete.append(selectedExercise)
            cell.backgroundColor = .red.withAlphaComponent(0.2)
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.red.cgColor
        }
        firstRightBarButton.isHidden = presenter.exercisesToDelete.count > 0 ? false : true
    }
}

//MARK: buttons actions
extension EditCreateWorkoutViewController {
    @objc func backBarButtonTapped() {
        presenter.backBarButtonTapped()
    }
    
    @objc func trashBarButtonTapped() {
        presenter.trashBarButtonTapped()
        collectionView.reloadData()
        firstRightBarButton.isHidden = true
        secondRightBarButton.isEnabled = presenter.exercisesData.count > 0 ? true : false
    }
    
    @objc func saveBarButtonTapped() {
        titleTextField.endEditing(true)
        presenter.saveBarButtonTapped()
    }
    
    @objc func addButtonTapped() {
        presenter.addBarButtonTapped()
    }
    
    @objc func detailButtonTapped(sender: UIButton) {
        presenter.detailButtonTapped(item: sender.tag)
    }
}

//MARK: work with keyboard
extension EditCreateWorkoutViewController {
    @objc func keyboardWillShow(notification: Notification) {
        var keyboardHeight: CGFloat = 0
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        
        tapScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        guard let tapScreen = tapScreen else {return}
        view.addGestureRecognizer(tapScreen)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        guard let tapScreen = tapScreen else {return}
        self.view.removeGestureRecognizer(tapScreen)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension EditCreateWorkoutViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {return}
        presenter.workout.title = text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 20
    }
}
