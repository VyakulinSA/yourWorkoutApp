//
//  CoreDataStorageManagerTests.swift
//  yourWorkoutAppTests
//
//  Created by Вякулин Сергей on 09.11.2021.
//

import XCTest
import Foundation
import CoreData
@testable import yourWorkoutApp

class MockCoreDataStack: CoreDataStack {
    override init() {
        super.init()
        
        //Creates an in-memory persistent store.
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        //Creates an NSPersistentContainer instance, passing in the modelName and NSManageObjectModel stored in the CoreDataStack.
        let container = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.model)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        //Assigns the in-memory persistent store to the container.
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        //Overrides the storeContainer in CoreDataStack.
        storeContainer = container
    }
}

class CoreDataStorageManagerTests: XCTestCase {

    var workoutStorageManager: DataStorageWorkoutManagerProtocol!
    var exerciseStorageManager: DataStorageExerciseManagerProtocol!
    var coreDataStack: CoreDataStackProtocol!
    
    override func setUpWithError() throws {
        coreDataStack = MockCoreDataStack()
        workoutStorageManager = CoreDataStorageManager(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        exerciseStorageManager = CoreDataStorageManager(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDownWithError() throws {
        coreDataStack = nil
        workoutStorageManager = nil
        exerciseStorageManager = nil
    }

    func testCreateAndReadWorkout() {
        let exercises = [
            ExerciseModel(title: "Ex1", muscleGroup: .chest, description: "ex1 description",
                          startImageName: "startPath ex1", endImageName: "endPath ex1", id: UUID()),
            ExerciseModel(title: "Ex2", muscleGroup: .chest, description: "ex2 description",
                          startImageName: "startPath ex2", endImageName: "endPath ex2", id: UUID())
        ]
        
        exerciseStorageManager.create(exercise: exercises[0])
        exerciseStorageManager.create(exercise: exercises[1])
        
        let id = UUID()
        workoutStorageManager.create(workout: WorkoutModel(title: "Test 1", muscleGroups: [.wholeBody,.abs], system: false, exercises: exercises, id: id))
        
        guard let allWorkouts = workoutStorageManager.readAllWorkouts(),
              let allExercises = exerciseStorageManager.readAllExercises() else {return}
        
        let workout = allWorkouts[0]
        
        XCTAssertNotNil(workout, "Wallet should not be nil")
        XCTAssertTrue(workout.title == "Test 1")
        XCTAssertTrue(workout.exercises.count == 2)
        XCTAssertTrue(workout.id == id)
        XCTAssertTrue(workout.muscleGroups == [.wholeBody,.abs])
        XCTAssertTrue(workout.system == false)
        
        XCTAssertNotNil(allExercises, "Wallet should not be nil")
        XCTAssertTrue(allExercises.count == 2)
    }
    
    func testUpdateWorkout() {
        let exercises = [
            ExerciseModel(title: "Ex1", muscleGroup: .chest, description: "ex1 description",
                          startImageName: "startPath ex1", endImageName: "endPath ex1", id: UUID()),
            ExerciseModel(title: "Ex2", muscleGroup: .chest, description: "ex2 description",
                          startImageName: "startPath ex2", endImageName: "endPath ex2", id: UUID())
        ]
        
        exerciseStorageManager.create(exercise: exercises[0])
        exerciseStorageManager.create(exercise: exercises[1])
        
        let id = UUID()
        workoutStorageManager.create(workout: WorkoutModel(title: "Test 1", muscleGroups: [.wholeBody,.abs], system: false, exercises: [exercises[0]], id: id))
        guard let allWorkouts = workoutStorageManager.readAllWorkouts() else {return}
        var workout = allWorkouts[0]
        
        XCTAssertNotNil(workout, "Wallet should not be nil")
        XCTAssertTrue(workout.title == "Test 1")
        XCTAssertTrue(workout.exercises.count == 1)
        XCTAssertTrue(workout.exercises[0].title == "Ex1")
        XCTAssertTrue(workout.id == id)
        XCTAssertTrue(workout.muscleGroups == [.wholeBody,.abs])
        XCTAssertTrue(workout.system == false)
        
        workout.exercises = [exercises[1]]
        workout.title = "update Test 1"
        workout.muscleGroups = [.chest]
        workout.system = true
        
        workoutStorageManager.update(workout: workout)
        
        guard let updateWorkouts = workoutStorageManager.readAllWorkouts() else {return}
        let updateW = updateWorkouts[0]
        
        XCTAssertNotNil(updateW, "Wallet should not be nil")
        XCTAssertTrue(updateW.title == "update Test 1")
        XCTAssertTrue(updateW.exercises.count == 1)
        XCTAssertTrue(updateW.exercises[0].title == "Ex2")
        XCTAssertTrue(updateW.id == id && updateW.id == workout.id)
        XCTAssertTrue(updateW.muscleGroups == [.chest])
        XCTAssertTrue(updateW.system == true)
    }
    
    func testDeleteWorkout() {
        let exercises = [
            ExerciseModel(title: "Ex1", muscleGroup: .chest, description: "ex1 description",
                          startImageName: "startPath ex1", endImageName: "endPath ex1", id: UUID()),
            ExerciseModel(title: "Ex2", muscleGroup: .chest, description: "ex2 description",
                          startImageName: "startPath ex2", endImageName: "endPath ex2", id: UUID())
        ]
        
        exerciseStorageManager.create(exercise: exercises[0])
        exerciseStorageManager.create(exercise: exercises[1])
        
        let workout1 = WorkoutModel(title: "Test 1", muscleGroups: [.wholeBody,.abs], system: false, exercises: [exercises[0]], id: UUID())
        let workout2 = WorkoutModel(title: "Test 2", muscleGroups: [.chest,], system: true, exercises: [exercises[1]], id: UUID())
        
        workoutStorageManager.create(workout: workout1)
        workoutStorageManager.create(workout: workout2)
        
        guard let allWorkouts = workoutStorageManager.readAllWorkouts(),
              let allExercises = exerciseStorageManager.readAllExercises() else {return}

        XCTAssertTrue(allWorkouts.count == 2)
        XCTAssertTrue(allExercises.count == 2)
        
        workoutStorageManager.delete(workout: workout1)
        
        guard let allWorkouts = workoutStorageManager.readAllWorkouts(),
              let allExercises = exerciseStorageManager.readAllExercises() else {return}
        
        XCTAssertTrue(allWorkouts.count == 1)
        XCTAssertTrue(allWorkouts[0].id == workout2.id)
        XCTAssertTrue(allExercises.count == 2)
        
    }
    
    func testDeleteAllWorkouts() {
        workoutStorageManager.create(workout: WorkoutModel(title: "Test 1", muscleGroups: [.wholeBody,.abs], system: false, exercises: [ExerciseModelProtocol](), id: UUID()))
        workoutStorageManager.create(workout: WorkoutModel(title: "Test 2", muscleGroups: [.chest,], system: true, exercises: [ExerciseModelProtocol](), id: UUID()))
        
        workoutStorageManager.deleteAllWorkouts()
        
        let allWorkouts = workoutStorageManager.readAllWorkouts()
        
        XCTAssertTrue(allWorkouts?.count == 0)
    }
    
    func testCreateAndReadExercise() {
        let id1 = UUID()
        
        let exercises = [
            ExerciseModel(title: "Ex1", muscleGroup: .chest, description: "ex1 description", startImageName: "startPath ex1", endImageName: "endPath ex1", id: id1)
        ]
        
        exerciseStorageManager.create(exercise: exercises[0])
        
        guard let resultExercises = exerciseStorageManager.readAllExercises() else {return}
        
        XCTAssertNotNil(resultExercises, "Wallet should not be nil")
        XCTAssertTrue(resultExercises[0].title == exercises[0].title)
        XCTAssertTrue(resultExercises[0].muscleGroup == exercises[0].muscleGroup)
        XCTAssertTrue(resultExercises[0].description == exercises[0].description)
        XCTAssertTrue(resultExercises[0].startImageName == exercises[0].startImageName)
        XCTAssertTrue(resultExercises[0].endImageName == exercises[0].endImageName)
        XCTAssertTrue(resultExercises[0].id == exercises[0].id)
    }
    
    func testUpdateExercise() {
        let exercises = [
            ExerciseModel(title: "Ex1", muscleGroup: .chest, description: "ex1 description",
                          startImageName: "startPath ex1", endImageName: "endPath ex1", id: UUID())
        ]
        
        exerciseStorageManager.create(exercise: exercises[0])
        
        
        guard let allExercises = exerciseStorageManager.readAllExercises() else {return}
        var exercise = allExercises[0]
        
        XCTAssertNotNil(exercise, "Wallet should not be nil")
        XCTAssertTrue(exercise.title == "Ex1")
        XCTAssertTrue(exercise.muscleGroup == .chest)
        XCTAssertTrue(exercise.description == "ex1 description")
        XCTAssertTrue(exercise.startImageName == "startPath ex1")
        XCTAssertTrue(exercise.endImageName == "endPath ex1")
        XCTAssertTrue(exercise.id == exercises[0].id)
        
        exercise.title = "update Ex1"
        exercise.muscleGroup = .abs
        exercise.description = "update description ex1"
        
        
        exerciseStorageManager.update(exercise: exercise)
        
        guard let allExercises = exerciseStorageManager.readAllExercises() else {return}
        let updateExercise = allExercises[0]
        
        XCTAssertNotNil(updateExercise, "Wallet should not be nil")
        XCTAssertTrue(updateExercise.title == "update Ex1")
        XCTAssertTrue(updateExercise.muscleGroup == .abs)
        XCTAssertTrue(updateExercise.description == "update description ex1")
        XCTAssertTrue(updateExercise.startImageName == exercises[0].startImageName)
        XCTAssertTrue(updateExercise.endImageName == exercises[0].endImageName)
        XCTAssertTrue(updateExercise.id == exercises[0].id)
    }
    
    func testDeleteExercise() {
        let exercises = [
            ExerciseModel(title: "Ex1", muscleGroup: .chest, description: "ex1 description",
                          startImageName: "startPath ex1", endImageName: "endPath ex1", id: UUID()),
            ExerciseModel(title: "Ex2", muscleGroup: .chest, description: "ex2 description",
                          startImageName: "startPath ex2", endImageName: "endPath ex2", id: UUID())
        ]
        
        exerciseStorageManager.create(exercise: exercises[0])
        exerciseStorageManager.create(exercise: exercises[1])
        
        guard let allExercises = exerciseStorageManager.readAllExercises() else {return}

        XCTAssertTrue(allExercises.count == 2)
        
        exerciseStorageManager.delete(exercise: exercises[0])
        
        guard let allExercises = exerciseStorageManager.readAllExercises() else {return}
        
        XCTAssertTrue(allExercises.count == 1)
        XCTAssertTrue(allExercises[0].id == exercises[1].id)
    }
}
