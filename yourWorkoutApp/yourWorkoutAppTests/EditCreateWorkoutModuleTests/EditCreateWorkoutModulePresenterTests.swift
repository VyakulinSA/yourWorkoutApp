//
//  EditCreateWorkoutModulePresenterTests.swift
//  yourWorkoutAppTests
//
//  Created by Вякулин Сергей on 15.11.2021.
//

import XCTest
@testable import yourWorkoutApp

class MokNavigationController: YWNavigationController {
    var popCount = 0
    var presentCount = 0
    var pushCount = 0
    
    var controllerOnScreen: UIViewController?
    
    override func popViewController(animated: Bool) -> UIViewController? {
        popCount += 1
        return super.popViewController(animated: animated)
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        presentCount += 1
        controllerOnScreen = viewControllerToPresent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushCount += 1
        controllerOnScreen = viewController
    }
}


class EditCreateWorkoutModulePresenterTests: XCTestCase {
    var coreDataStack: CoreDataStackProtocol!
    var workoutStorageManager: DataStorageWorkoutManagerProtocol!
    var imagesStorageManager: ImagesStorageManagerProtocol!
    var navController: MokNavigationController!
    var assemblyConfigurator: AssembliConfiguratorProtocol!
    
    var router: RouterConfigurator!
    var presenter: EditCreateWorkoutPresenter!
    
    var workout: WorkoutModelProtocol!
    var exercisesData: [ExerciseModelProtocol]!

    override func setUpWithError() throws {
        coreDataStack = MockCoreDataStack()
        workoutStorageManager = CoreDataStorageManager(managedObjectContext: coreDataStack.mainContext,
                                                       coreDataStack: coreDataStack)
        
        imagesStorageManager = ImagesStorageManager()
        navController = MokNavigationController()
        assemblyConfigurator = AssemblyConfigurator()
        
        router = RouterConfigurator(navController: navController,
                                    assemblyConfigurator: assemblyConfigurator)
        
        workout = WorkoutModel(title: "testWorkout",
                               muscleGroups: [MuscleGroup](),
                               system: false,
                               exercises: [ExerciseModel](),
                               id: UUID())
        workoutStorageManager.create(workout: workout)
        
        presenter = EditCreateWorkoutPresenter(workoutStorageManager: workoutStorageManager,
                                               imagesStorageManager: imagesStorageManager,
                                               router: router,
                                               editCreateType: .edit, workout: workout)
        
        exercisesData = [ExerciseModel(title: "test ex1",
                                           muscleGroup: .chest,
                                           description: "test description",
                                           startImageName: nil,
                                           endImageName: nil,
                                           id: UUID()),
                             ExerciseModel(title: "test ex2",
                                           muscleGroup: .chest,
                                           description: "test description",
                                           startImageName: nil,
                                           endImageName: nil,
                                           id: UUID())]
    }
    
    override func tearDownWithError() throws {
        coreDataStack = nil
        workoutStorageManager = nil
        navController = nil
        assemblyConfigurator = nil
        router = nil
        workout = nil
        presenter = nil
        
    }
    
    func testBackBarButtonTapped() {
        presenter.backBarButtonTapped()
        XCTAssertTrue(navController.popCount == 1)
        XCTAssertNil(navController.controllerOnScreen)
        
        presenter.workout.title = "updated title"
        presenter.backBarButtonTapped()
        
        XCTAssertTrue(navController.popCount == 1)
        XCTAssertTrue(navController.presentCount == 1)
        XCTAssertTrue(navController.controllerOnScreen is UIAlertController)
    }
    
    func testSaveBarButtonTapped() {
        presenter.editCreateType = .edit

        
        presenter.workout.title = ""
        presenter.exercisesData = exercisesData
        presenter.saveBarButtonTapped()
        let updatedWorkout = workoutStorageManager.readWorkout(id: workout.id)
        
        XCTAssertTrue(updatedWorkout?.title == "Unknown workout")
        
        presenter.editCreateType = .create
        presenter.saveBarButtonTapped()
        
        XCTAssertTrue(navController.presentCount == 1)
        XCTAssertTrue(navController.controllerOnScreen is UIAlertController)
    }
    
    func testAddBarButtonTapped() {
        presenter.addBarButtonTapped()
        
        XCTAssertTrue(navController.pushCount == 1)
        XCTAssertTrue(navController.controllerOnScreen is AddExerciseViewController)
    }
    
    func testTrashBarButtonTapped() {
        presenter.exercisesData = exercisesData
        presenter.exercisesToDelete = [exercisesData[0]]
        
        presenter.trashBarButtonTapped()
        
        XCTAssertTrue(presenter.exercisesData.count == 1)
        XCTAssertTrue(presenter.exercisesData[0].id == exercisesData[1].id)
        XCTAssertTrue(presenter.exercisesToDelete.count == 0)
    }
    
    func testDetailButtonTapped() {
        presenter.exercisesData = exercisesData
        presenter.detailButtonTapped(item: 1)
        
        XCTAssertTrue(navController.pushCount == 1)
        
        let pushVC = navController.controllerOnScreen as? ExerciseDetailViewController
        
        XCTAssertNotNil(pushVC)
        XCTAssertTrue(pushVC?.presenter.exercise.id == exercisesData[1].id)
    }
    
    func testAccept() {
        presenter.editCreateType = .edit
        XCTAssertNoThrow(presenter.accept())
        
        presenter.editCreateType = .create
        let workout = WorkoutModel(title: "",
                               muscleGroups: [MuscleGroup](),
                               system: false,
                               exercises: [ExerciseModel](),
                               id: UUID())
        presenter.workout = workout
        
        presenter.accept()
        
        let readWorkout = workoutStorageManager.readWorkout(id: workout.id)
        
        XCTAssertTrue(readWorkout?.id == workout.id)
        XCTAssertTrue(readWorkout?.title == "Unknown workout")
        XCTAssertTrue(navController.popCount == 1)
    }
    
    func testDeleteChanges() {
        presenter.deleteChanges()
        XCTAssertTrue(navController.popCount == 1)
    }

}
