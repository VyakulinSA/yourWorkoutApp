//
//  ExerciseDetailPresenterTests.swift
//  yourWorkoutAppTests
//
//  Created by Вякулин Сергей on 16.11.2021.
//

import XCTest
@testable import yourWorkoutApp

class ExerciseDetailPresenterTests: XCTestCase {
    var coreDataStack: CoreDataStackProtocol!
    var dataStorageManager: CoreDataStorageManager!
    var imagesStorageManager: ImagesStorageManagerProtocol!
    var navController: MokNavigationController!
    var assemblyConfigurator: AssembliConfiguratorProtocol!
    
    var router: RouterConfigurator!
    var presenter: ExerciseDetailPresenter!
    
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
        
        presenter = ExerciseDetailPresenter(exerciseStorageManager: dataStorageManager,
                                            imagesStorageManager: imagesStorageManager,
                                            router: router,
                                            exercise: exercisesData[1],
                                            editable: false)
        
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
    
    func testBackBarButtonTapped() {
        presenter.backBarButtonTapped()
        XCTAssertTrue(navController.popCount == 1)
    }
    
    func testEditButtonTapped() {
        XCTAssertTrue(navController.pushCount == 0)
        presenter.editButtonTapped()
        XCTAssertTrue(navController.pushCount == 1)
        
        let presentVC = navController.controllerOnScreen as? EditCreateExerciseViewController
        XCTAssertNotNil(presentVC)
        XCTAssertTrue(presentVC?.presenter.editCreateType == .edit)
        XCTAssertTrue(presentVC?.presenter.exercise.id == presenter.exercise.id)
    }
    
    func testGetActualExercise() {
        var updatedExercise = exercisesData[1]
        updatedExercise.title = "updated test"
        
        dataStorageManager.update(exercise: updatedExercise)
        XCTAssertTrue(presenter.exercise.title == exercisesData[1].title)
        presenter.getActualExercise()
        
        XCTAssertTrue(presenter.exercise.title == "updated test")
    }
}
