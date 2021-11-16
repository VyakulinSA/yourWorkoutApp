//
//  WorkoutDetailPresenterTests.swift
//  yourWorkoutAppTests
//
//  Created by Вякулин Сергей on 15.11.2021.
//

import XCTest
@testable import yourWorkoutApp

class WorkoutDetailPresenterTests: XCTestCase {
    var coreDataStack: CoreDataStackProtocol!
    var workoutStorageManager: DataStorageWorkoutManagerProtocol!
    var imagesStorageManager: ImagesStorageManagerProtocol!
    var navController: YWNavigationController!
    var assemblyConfigurator: AssembliConfiguratorProtocol!
    
    var router: RouterConfigurator!
    var presenter: WorkoutDetailPresenter!
    
    var workout: WorkoutModelProtocol!
    
    override func setUpWithError() throws {
        coreDataStack = MockCoreDataStack()
        workoutStorageManager = CoreDataStorageManager(managedObjectContext: coreDataStack.mainContext,
                                                       coreDataStack: coreDataStack)
        
        imagesStorageManager = ImagesStorageManager()
        navController = YWNavigationController()
        assemblyConfigurator = AssemblyConfigurator()
        
        router = RouterConfigurator(navController: navController, assemblyConfigurator: assemblyConfigurator)
        
        workout = WorkoutModel(title: "testWorkout",
                               muscleGroups: [.chest],
                               system: false,
                               exercises: [ExerciseModel](),
                               id: UUID())
        
        presenter = WorkoutDetailPresenter(workoutStorageManager: workoutStorageManager,
                                           imagesStorageManager: imagesStorageManager,
                                           router: router,
                                           workout: workout)
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
    
    func testGearBarButtonTapped() {
        presenter.workout = WorkoutModel(title: "test1",
                                         muscleGroups: [.shoulders],
                                         system: false,
                                         exercises: [ExerciseModel](),
                                         id: UUID()
        )
        presenter.gearBarButtonTapped()
        
        XCTAssertFalse(router.navigationController?.viewControllers[0] is WorkoutsViewController)
        XCTAssertTrue(router.navigationController?.viewControllers[0] is EditCreateWorkoutViewController)
        let presentedController = router.navigationController?.viewControllers[0] as? EditCreateWorkoutViewController
        
        XCTAssertNotNil(presentedController)
        XCTAssertTrue(presentedController?.presenter.editCreateType == .edit)
        XCTAssertTrue(presentedController?.presenter.workout.title == "test1")
    }
    
    func testGetActualExercise() {
        workoutStorageManager.create(workout: workout)
        workout.title = "updated test"
        
        workoutStorageManager.update(workout: workout)
        XCTAssertTrue(presenter.workout.title == "testWorkout")
        presenter.getActualExercise()
        
        XCTAssertTrue(presenter.workout.title == "updated test")
    }
    
    func testDidSelectExercise() {
        presenter.exercisesData = [ExerciseModel(title: "test ex",
                                    muscleGroup: .chest,
                                    description: "test description",
                                    startImageName: nil,
                                    endImageName: nil,
                                    id: UUID())]
        
        presenter.didSelectExercise(item: 0)
        
        XCTAssertFalse(router.navigationController?.viewControllers[0] is WorkoutsViewController)
        XCTAssertTrue(router.navigationController?.viewControllers[0] is ExerciseDetailViewController)
        let presentedController = router.navigationController?.viewControllers[0] as? ExerciseDetailViewController
        
        XCTAssertNotNil(presentedController)
        XCTAssertTrue(presentedController?.presenter.exercise.id == presenter.exercisesData?[0].id)
        XCTAssertTrue(presentedController?.presenter.exercise.title == "test ex")
    }
    
    func testDeleteChanges() {
        workoutStorageManager.create(workout: workout)
        presenter.getActualExercise()
        
        XCTAssertTrue(presenter.workout.title == "testWorkout")
        presenter.trashBarButtonTapped()
        presenter.deleteChanges()
        
        let work = workoutStorageManager.readWorkout(id: workout.id)
        
        XCTAssertNil(work)
    }
    
    func testGetExerciseImages() {
        let image = UIImage(systemName: "pencil")
        let imageName = "testImage_112233"
        
        let name = imagesStorageManager.save(image: image, withName: imageName)
        
        XCTAssertNotNil(name)
        XCTAssertTrue(name == imageName)
        
        let savedImage = presenter.getImagesFromExercise(imageName: name)
        
        XCTAssertNotNil(savedImage)
        
        let deleteImage = imagesStorageManager.save(image: nil, withName: imageName)
        
        XCTAssertNil(deleteImage)
        
        let savedImageAfterDelete = imagesStorageManager.load(imageName: imageName)
        
        XCTAssertNil(savedImageAfterDelete)
    }

}
