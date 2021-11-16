//
//  StartMenuPresenterTests.swift
//  yourWorkoutAppTests
//
//  Created by Вякулин Сергей on 15.11.2021.
//

import XCTest
@testable import yourWorkoutApp

class StartMenuPresenterTests: XCTestCase {
    var navController: YWNavigationController!
    var assemblyConfigurator: AssemblyConfigurator!
    var router: RouterConfigurator!
    var presenter: StartMenuPresenter!

    override func setUpWithError() throws {
        navController = YWNavigationController()
        assemblyConfigurator = AssemblyConfigurator()
        router = RouterConfigurator(navController: navController, assemblyConfigurator: assemblyConfigurator)
        presenter = StartMenuPresenter(router: router)
    }

    override func tearDownWithError() throws {
        navController = nil
        assemblyConfigurator = nil
        router = nil
        presenter = nil
    }
    
    func testWorkoutsButtonTapped() {
        presenter.workoutsButtonTapped()
        
        XCTAssertTrue(router.navigationController?.viewControllers.count == 1)
        XCTAssertFalse(router.navigationController?.viewControllers[0] is ExercisesViewController)
        XCTAssertTrue(router.navigationController?.viewControllers[0] is WorkoutsViewController)
    }
    
    func testExercisesButtonTapped() {
        presenter.exercisesButtonTapped()
        
        XCTAssertTrue(router.navigationController?.viewControllers.count == 1)
        XCTAssertFalse(router.navigationController?.viewControllers[0] is WorkoutsViewController)
        XCTAssertTrue(router.navigationController?.viewControllers[0] is ExercisesViewController)
    }
    
    func testLeaguesButtonTapped() {
        presenter.leaguesButtonTapped()
        
        XCTAssertTrue(router.navigationController?.viewControllers.count == 1)
        XCTAssertFalse(router.navigationController?.viewControllers[0] is ExercisesViewController)
        XCTAssertTrue(router.navigationController?.viewControllers[0] is LeaguesViewController)
    }
}
