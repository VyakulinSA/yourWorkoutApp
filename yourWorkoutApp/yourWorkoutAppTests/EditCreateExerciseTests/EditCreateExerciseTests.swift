//
//  EditCreateExerciseTests.swift
//  yourWorkoutAppTests
//
//  Created by Вякулин Сергей on 16.11.2021.
//

import XCTest
@testable import yourWorkoutApp

class EditCreateExerciseTests: XCTestCase {
    var coreDataStack: CoreDataStackProtocol!
    var dataStorageManager: CoreDataStorageManager!
    var imagesStorageManager: ImagesStorageManagerProtocol!
    var navController: MokNavigationController!
    var assemblyConfigurator: AssembliConfiguratorProtocol!
    
    var router: RouterConfigurator!
    var presenter: EditCreateExercisePresenter!
    
    var exercisesData: [ExerciseModelProtocol]!

    override func setUpWithError() throws {
        coreDataStack = MockCoreDataStack()
        dataStorageManager = CoreDataStorageManager(managedObjectContext: coreDataStack.mainContext,
                                                       coreDataStack: coreDataStack)
        
        imagesStorageManager = ImagesStorageManager()
        navController = MokNavigationController()
        assemblyConfigurator = AssemblyConfigurator()
        
        router = RouterConfigurator(navController: navController,
                                    assemblyConfigurator: assemblyConfigurator)
        
        exercisesData = [ExerciseModel(title: "test ex1",
                                           muscleGroup: .chest,
                                           description: "test1 description",
                                           startImageName: nil,
                                           endImageName: nil,
                                           id: UUID()),
                             ExerciseModel(title: "test ex2",
                                           muscleGroup: .shoulders,
                                           description: "test2 description",
                                           startImageName: nil,
                                           endImageName: nil,
                                           id: UUID())]

        

        dataStorageManager.create(exercise: exercisesData[0])
        dataStorageManager.create(exercise: exercisesData[1])
        
        presenter = EditCreateExercisePresenter(exerciseStorageManager: dataStorageManager,
                                                imagesStorageManager: imagesStorageManager,
                                                router: router,
                                                editCreateType: .create, exercise: nil)
        
    }
    
    override func tearDownWithError() throws {
        coreDataStack = nil
        dataStorageManager = nil
        imagesStorageManager = nil
        navController = nil
        assemblyConfigurator = nil
        router = nil
        presenter = nil
        exercisesData = nil
    }
    
    func testWriteExerciseIMage() {
        let startImage = UIImage(systemName: "trash")
        let endImage = UIImage(systemName: "trash")
        
        presenter.startExerciseImage = startImage
        presenter.endExerciseImage = endImage
        
        XCTAssertNotNil(presenter.startExerciseImage)
        XCTAssertNotNil(presenter.endExerciseImage)
        
        presenter.writeExerciseImages(image: nil, selectedCell: .start)
        XCTAssertNil(presenter.startExerciseImage)
        presenter.writeExerciseImages(image: nil, selectedCell: .end)
        XCTAssertNil(presenter.endExerciseImage)
    }
    
    func testBackBarButtonTapped() {
        XCTAssertTrue(navController.popCount == 0)
        presenter.backBarButtonTapped()
        XCTAssertTrue(navController.popCount == 1)
        
        presenter.writeExerciseImages(image: nil, selectedCell: .start)
        XCTAssertTrue(navController.presentCount == 0)
        presenter.backBarButtonTapped()
        XCTAssertTrue(navController.presentCount == 1)
        let vcOnScreen = navController.controllerOnScreen as? ActionsForChangesAlert
        XCTAssertNotNil(vcOnScreen)
        
        presenter.editCreateType = .edit
        presenter.backBarButtonTapped()
        XCTAssertTrue(navController.presentCount == 2)
        
    }
    
    func testTrashBarButtonTapped() {
        XCTAssertTrue(navController.presentCount == 0)
        presenter.trashBarButtonTapped()
        XCTAssertTrue(navController.presentCount == 1)
        let vcOnScreen = navController.controllerOnScreen as? ActionsForChangesAlert
        XCTAssertNotNil(vcOnScreen)
    }
    
    func testAddImageButtonTapped() {
        XCTAssertTrue(navController.presentCount == 0)
        presenter.addImageButtonTapped(item: 0)
        XCTAssertTrue(navController.presentCount == 1)
        let vcOnScreen = navController.controllerOnScreen as? SelectExerciseImageActionsheet
        XCTAssertNotNil(vcOnScreen)
    }
    
    func testCameraPhotoAction() {
        var source: UIImagePickerController.SourceType = .camera
        presenter.cameraAction(source: source, selectedImageCell: nil)
        XCTAssertNil(navController.controllerOnScreen)
        XCTAssertTrue(navController.presentCount == 0)
        
        presenter.cameraAction(source: source, selectedImageCell: .start)
        if UIImagePickerController.isSourceTypeAvailable(source){
            XCTAssertTrue(navController.presentCount == 1)
        } else {
            XCTAssertTrue(navController.presentCount == 0)
        }
        
        source = .photoLibrary
        presenter.photoAction(source: source, selectedImageCell: .start)
        
        XCTAssertTrue(navController.presentCount == 1)
        let vcOnScreen = navController.controllerOnScreen as? SelectExerciseImagePicker
        XCTAssertNotNil(vcOnScreen)
    }
    
    func testDeletePhotoAction() {
        presenter.deletePhotoAction(selectedImageCell: .start)
        XCTAssertNil(presenter.startExerciseImage)
        presenter.deletePhotoAction(selectedImageCell: .end)
        XCTAssertNil(presenter.endExerciseImage)
    }
    
    func testAcceptWithDel() {
        presenter.exercise = exercisesData[0]
        presenter.trashBarButtonTapped()
        presenter.accept()
        XCTAssertTrue(navController.popToRootCount == 1)
        let exercises = dataStorageManager.readAllExercises()
        XCTAssertTrue(exercises?.count == 1)
        XCTAssertTrue(exercises?[0].id == exercisesData[1].id)
    }
    
    func testAcceptWithEmptyTitle() {
        presenter.exercise = exercisesData[0]
        presenter.exercise.title = ""
        presenter.accept()
        XCTAssertTrue(navController.presentCount == 1)
        XCTAssertNotNil(navController.controllerOnScreen as? UIAlertController)
    }
    
    func testAcceptGood() {
        let testExercise = ExerciseModel(title: "accept",
                                         muscleGroup: .abs,
                                         description: "",
                                         startImageName: nil,
                                         endImageName: nil,
                                         id: UUID())
        presenter.exercise = testExercise
        
        presenter.editCreateType = .create
        presenter.accept()
        
        var loadEcsercise = dataStorageManager.readExercise(id: testExercise.id)
        XCTAssertNotNil(loadEcsercise)
        
        presenter.editCreateType = .edit
        presenter.exercise.title = "acceptEdit"
        presenter.accept()
        
        loadEcsercise = dataStorageManager.readExercise(id: testExercise.id)
        XCTAssertNotNil(loadEcsercise)
        XCTAssertFalse(loadEcsercise?.title == testExercise.title)
        XCTAssertTrue(loadEcsercise?.title == "acceptEdit")
        
    }
    
    func testDeleteChanges() {
        XCTAssertTrue(navController.popCount == 0)
        presenter.deleteChanges()
        XCTAssertTrue(navController.popCount == 1)
    }
}
