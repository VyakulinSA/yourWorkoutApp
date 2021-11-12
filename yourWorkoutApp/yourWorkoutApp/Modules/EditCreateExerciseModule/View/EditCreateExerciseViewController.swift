//
//  EditCreateExerciseViewController.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 04.11.2021.
//

import UIKit

class EditCreateExerciseViewController: YWExerciseContainerViewController, EditCreateExerciseViewInput {
    
    var presenter: EditCreateExerciseViewOutput
    var tapScreen: UIGestureRecognizer?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        print("EditCreateExerciseViewController wilAppear reload")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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

extension EditCreateExerciseViewController {
    
    private func configViews() {
        remotePresenter = presenter
        
        let secondRightBarButtonName = presenter.editCreateType == .edit ? IconButtonNames.trash : nil
        
        let title = presenter.editCreateType == .edit ? "EDIT EXERCISE" : "CREATE EXERCISE"
        
        setupNavBarItems(leftBarButtonName: .backArrow, firstRightBarButtonName: nil, secondRightBarButtonName: secondRightBarButtonName, titleBarText: title)
        
        secondRightBarButton.normalColor = .red
        secondRightBarButton.setupAppearance(systemNameImage: secondRightBarButtonName)
        secondRightBarButton.isHidden = presenter.editCreateType == .edit ? false : true
        
        leftBarButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        secondRightBarButton.addTarget(self, action: #selector(trashBarButtonTapped), for: .touchUpInside)
    }

    @objc func backBarButtonTapped() {
        view.endEditing(true)
        presenter.backBarButtonTapped()
    }
    
    @objc func trashBarButtonTapped() {
        //FIXME: удаление будет происходить из presentera, напрямую из базы, данный функционал для теста, если буду дальше использовать, то сделать проверку по всем полям, а не только по названию
        guard let rootVC = navigationController?.viewControllers[0] as? ExercisesViewController else {return}
        rootVC.presenter.exercisesData?.removeAll(where: { exercise in
            exercise.title == presenter.exercise?.title
        })
        presenter.trashBarButtonTapped()
    }
    
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
    
    func reloadCollection() {
        collectionView.reloadData()
        print("EditCreateExerciseViewController wilAppear reload")
    }
    
}


//MARK: config collectionView for edit type
extension EditCreateExerciseViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let identifier = CellSettings.allCases[indexPath.item].identifierCell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        //FIXME: поправить отрисовку ячеек
            switch cell {
                //images
            case let cell as ExerciseImagesCollectionViewCell:
                cell.remotePresenter = presenter
                cell.setupImagesData(startImageData: presenter.startExerciseImage, endImageData: presenter.endExerciseImage)
                return cell
                //muscle
            case let cell as ExerciseMuscleGroupCollectionViewCell:
                cell.remotePresenter = presenter
                cell.titleTextField.text = presenter.exercise?.muscleGroup.rawValue
                return cell
                //description
            case let cell as ExerciseDescriptionCollectionViewCell:
                cell.remotePresenter = presenter
                if let exercise = presenter.exercise, exercise.description.count > 0 {
                    cell.descriptionTextView.text = exercise.description
                    cell.descriptionTextView.textColor = .darkTextColor
                }
                return cell
                //title
            case let cell as ExerciseTitleCollectionViewCell:
                cell.remotePresenter = presenter
                cell.titleTextField.text = presenter.exercise?.title ?? ""
                return cell
                
            default:
                return cell
            }
        }
}
