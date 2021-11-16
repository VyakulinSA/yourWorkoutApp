//
//  AddExercisePresenterTests.swift
//  yourWorkoutAppTests
//
//  Created by Вякулин Сергей on 16.11.2021.
//

import XCTest
@testable import yourWorkoutApp

class AddExercisePresenterTests: XCTestCase {
    var coreDataStack: CoreDataStackProtocol!
    var dataStorageManager: CoreDataStorageManager!
    var imagesStorageManager: ImagesStorageManagerProtocol!
    var navController: MokNavigationController!
    var assemblyConfigurator: AssembliConfiguratorProtocol!
    
    var router: RouterConfigurator!
    var delegate: EditCreateWorkoutPresenter!
    var presenter: AddExercisePresenter!
    
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
        
        delegate = EditCreateWorkoutPresenter(workoutStorageManager: dataStorageManager,
                                              imagesStorageManager: imagesStorageManager,
                                              router: router,
                                              editCreateType: .create,
                                              workout: nil)
        
        presenter = AddExercisePresenter(imagesStorageManager: imagesStorageManager,
                                         exerciseStorageManager: dataStorageManager,
                                         router: router,
                                         delegate: delegate)
        
    }
    
    override func tearDownWithError() throws {
        coreDataStack = nil
        dataStorageManager = nil
        imagesStorageManager = nil
        navController = nil
        assemblyConfigurator = nil
        router = nil
        delegate = nil
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
    
    func testBackBarButtonTapped() {
        presenter.backBarButtonTapped()
        XCTAssertTrue(navController.popCount == 1)
    }
    
    func testFilterBarButtonTapped() {
        XCTAssertTrue(navController.presentCount == 0)
        presenter.filterBarButtonTapped()
        XCTAssertTrue(navController.presentCount == 1)
        let presentVC = navController.controllerOnScreen as? FilterExerciseViewController
        XCTAssertNotNil(presentVC)
    }
    
    func testDetailButtonTapped() {
        XCTAssertTrue(navController.pushCount == 0)
        
        presenter.detailButtonTapped(item: 1)
        XCTAssertTrue(navController.pushCount == 1)
        let presentVC = navController.controllerOnScreen as? ExerciseDetailViewController
        XCTAssertNotNil(presentVC)
        XCTAssertFalse(presentVC!.presenter.editable)
        XCTAssertTrue(presentVC?.presenter.exercise.id == exercisesData[1].id)
        
        presenter.exercisesData = nil
        presenter.detailButtonTapped(item: 1)
        XCTAssertTrue(navController.pushCount == 1)
    }
    
    func testDidSelectCell() {
        XCTAssertNotNil(delegate.exercisesData)
        XCTAssertTrue(delegate.exercisesData.count == 0)
        
        presenter.exercisesData = nil
        presenter.didSelectCell(item: 1)
        
        XCTAssertNotNil(delegate.exercisesData)
        XCTAssertTrue(delegate.exercisesData.count == 0)
        
        presenter.exercisesData = exercisesData
        presenter.didSelectCell(item: 0)
        
        XCTAssertNotNil(delegate.exercisesData)
        XCTAssertTrue(delegate.exercisesData.count == 1)
        XCTAssertTrue(delegate.exercisesData[0].id == exercisesData[0].id)
        XCTAssertTrue(navController.popCount == 1)
        
    }
    
    func testGetExercisesData() {
        XCTAssertTrue(presenter.exercisesData?.count == 2)
        delegate.exercisesData = [exercisesData[0]]
        presenter.getExercisesData()
        XCTAssertTrue(presenter.exercisesData?.count == 1)
        XCTAssertTrue(presenter.exercisesData?[0].id == exercisesData[1].id)
        XCTAssertTrue(presenter.exercisesData?[0].id != delegate.exercisesData[0].id)
    }
    
//    func getExercisesData() {
//        exercisesData = exerciseStorageManager.readAllExercises()
//        guard let exercisesData = exercisesData else {return}
//        self.exercisesData = exercisesData.filter { exercise in
//            return !(self.delegate?.exercisesData.contains{$0.id == exercise.id} ?? false)
//        }
//    }
    

}
