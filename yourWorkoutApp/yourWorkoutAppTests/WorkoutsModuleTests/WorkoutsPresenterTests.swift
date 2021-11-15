//
//  WorkoutsPresenterTests.swift
//  yourWorkoutAppTests
//
//  Created by Вякулин Сергей on 15.11.2021.
//

import XCTest
@testable import yourWorkoutApp

class WorkoutsPresenterTests: XCTestCase {
    var coreDataStack: CoreDataStackProtocol!
    var workoutStorageManager: DataStorageWorkoutManagerProtocol!
    
    var navController: NavigationControllerProtocol!
    var assemblyConfigurator: AssembliConfiguratorProtocol!
    var router: RouterConfigurator!
    var presenter: WorkoutsPresenter!
    
    override func setUpWithError() throws {
        coreDataStack = MockCoreDataStack()
        workoutStorageManager = CoreDataStorageManager(managedObjectContext: coreDataStack.mainContext,
                                                       coreDataStack: coreDataStack)
        navController = YWNavigationController()
        assemblyConfigurator = AssemblyConfigurator()
        router = RouterConfigurator(navController: navController, assemblyConfigurator: assemblyConfigurator)
        presenter = WorkoutsPresenter(workoutStorageManager: workoutStorageManager, router: router)
    }
    
    override func tearDownWithError() throws {
        coreDataStack = nil
        workoutStorageManager = nil
        navController = nil
        assemblyConfigurator = nil
        router = nil
        presenter = nil
        
    }
    
    func testStratMenuButtonTapped() {
        presenter.startMenuButtonTapped()
        
        XCTAssertTrue(router.navigationController?.viewControllers.count == 1)
        XCTAssertFalse(router.navigationController?.viewControllers[0] is WorkoutsViewController)
        XCTAssertTrue(router.navigationController?.viewControllers[0] is StartMenuViewController)
    }
    
    func testAddBarButtonTapped() {
        presenter.addBarButtonTapped()
        
        XCTAssertFalse(router.navigationController?.viewControllers[0] is WorkoutsViewController)
        XCTAssertTrue(router.navigationController?.viewControllers[0] is EditCreateWorkoutViewController)
        let presentedController = router.navigationController?.viewControllers[0] as? EditCreateWorkoutViewController
        
        XCTAssertNotNil(presentedController)
        XCTAssertTrue(presentedController?.presenter.editCreateType == .create)
        XCTAssertTrue(presentedController?.presenter.workout.title == "")
    }
    
    func testDidSelectItem() {
        let wData =
            WorkoutModel(title: "test1",
                         muscleGroups: [.shoulders],
                         system: false,
                         exercises: [ExerciseModel](),
                         id: UUID()
            )
        
        workoutStorageManager.create(workout: wData)
        XCTAssertTrue(presenter.workoutsData?.count ?? 0 == 0)
        presenter.getWorkoutsData()
        
        XCTAssertTrue(presenter.workoutsData?.count ?? 0 > 0)
        
        presenter.didSelectItem(item: 0)
        
        XCTAssertFalse(router.navigationController?.viewControllers[0] is WorkoutsViewController)
        XCTAssertTrue(router.navigationController?.viewControllers[0] is WorkoutDetailViewController)
        let presentedController = router.navigationController?.viewControllers[0] as? WorkoutDetailViewController
        
        XCTAssertNotNil(presentedController)
        XCTAssertTrue(presentedController?.presenter.workout.id == wData.id)
        XCTAssertFalse(presentedController?.presenter.workout.title == "")
    }
}
