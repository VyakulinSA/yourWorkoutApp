//
//  ExercisesPresenterTests.swift
//  yourWorkoutAppTests
//
//  Created by Вякулин Сергей on 16.11.2021.
//

import XCTest
@testable import yourWorkoutApp

class ExercisesPresenterTests: XCTestCase {
    var coreDataStack: CoreDataStackProtocol!
    var dataStorageManager: CoreDataStorageManager!
    var imagesStorageManager: ImagesStorageManagerProtocol!
    var navController: MokNavigationController!
    var assemblyConfigurator: AssembliConfiguratorProtocol!
    
    var router: RouterConfigurator!
    var presenter: ExercisesPresenter!
    
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
        
        presenter = ExercisesPresenter(exerciseStorageManager: dataStorageManager,
                                       imagesStorageManager: imagesStorageManager,
                                       router: router)
        
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
    
    func testSelectedFilterMuscleGroups() {
        XCTAssertTrue(presenter.exercisesData?.count == 2)
        
        presenter.selectedFilterMuscleGroups = nil
        XCTAssertTrue(presenter.exercisesData?.count == 2)
        
        presenter.selectedFilterMuscleGroups = [.shoulders]
        XCTAssertTrue(presenter.exercisesData?.count == 1)
        XCTAssertTrue(presenter.exercisesData?[0].id == exercisesData[1].id)
    }
    
    func testStartMenuButtonTapped() {
        XCTAssertTrue(navController.viewControllers.count == 0)
        presenter.startMenuButtonTapped()
        XCTAssertTrue(navController.viewControllers.count == 1)
        XCTAssertTrue(navController.viewControllers[0] is StartMenuViewController)
        
    }
    
    func testFilterBarButtonTapped() {
        XCTAssertTrue(navController.presentCount == 0)
        presenter.filterBarButtonTapped()
        XCTAssertTrue(navController.presentCount == 1)
        let presentVC = navController.controllerOnScreen as? FilterExerciseViewController
        XCTAssertNotNil(presentVC)
    }
    
    func testCreateBarButtonTapped() {
        XCTAssertTrue(navController.pushCount == 0)
        presenter.createBarButtonTapped()
        XCTAssertTrue(navController.pushCount == 1)
        let presentVC = navController.controllerOnScreen as? EditCreateExerciseViewController
        XCTAssertNotNil(presentVC)
        XCTAssertTrue(presentVC?.presenter.editCreateType == .create)
        XCTAssertTrue(presentVC?.presenter.exercise.title == "")
    }
    
    func testDidSelectCell() {
        presenter.exercisesData = nil
        XCTAssertTrue(navController.pushCount == 0)
        
        presenter.exercisesData = exercisesData
        presenter.didSelectCell(item: 0)
        XCTAssertTrue(navController.pushCount == 1)
        
        let presentVC = navController.controllerOnScreen as? ExerciseDetailViewController
        XCTAssertNotNil(presentVC)
        XCTAssertTrue(presentVC!.presenter.editable)
        XCTAssertTrue(presentVC?.presenter.exercise.id == exercisesData[0].id)
    }
}
