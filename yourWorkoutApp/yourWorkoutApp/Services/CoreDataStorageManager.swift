//
//  CoreDataStorageManager.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 07.11.2021.
//

import Foundation
import CoreData

protocol DataStorageWorkoutManagerProtocol: AnyObject {
    func create(workout: WorkoutModelProtocol)
    func readAllWorkouts() -> [WorkoutModelProtocol]?
    func readWorkout(id: UUID) -> WorkoutModelProtocol?
    func update(workout: WorkoutModelProtocol)
    func delete(workout: WorkoutModelProtocol)
    func deleteAllWorkouts()
    
//    func add(exercises: [ExerciseModelProtocol]?, for workout: WorkoutModelProtocol)
//    func getExercises(from workout: WorkoutModelProtocol) -> [ExerciseModelProtocol]?
}

protocol DataStorageExerciseManagerProtocol: AnyObject {
    func create(exercise: ExerciseModelProtocol)
    func readAllExercises() -> [ExerciseModelProtocol]?
    func readExercise(id: UUID) -> ExerciseModelProtocol?
    func update(exercise: ExerciseModelProtocol)
    func delete(exercise: ExerciseModelProtocol)
}

class CoreDataStorageManager {
    var managedObjectContext: NSManagedObjectContext
    var coreDataStack: CoreDataStackProtocol
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStackProtocol) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
}

extension CoreDataStorageManager: DataStorageWorkoutManagerProtocol {
   //MARK: Create Workout with Exercises
    func create(workout: WorkoutModelProtocol) {
        guard let workoutCD = NSEntityDescription.insertNewObject(forEntityName: "WorkoutCD", into: managedObjectContext) as? WorkoutCD else {return}
        
        workoutCD.id = workout.id
        workoutCD.title = workout.title
        workoutCD.system = workout.system
        workoutCD.muscleGroups = workout.muscleGroups.map{$0.rawValue}.joined(separator: "|")
        workoutCD.exercisesCount = Int16(workout.exercises.count)
        
        var exercisesCD: [ExerciseCD] = [ExerciseCD]()
        
        workout.exercises.forEach({ ex in
            if let exСD = getCoreDataOneEntity(withType: ExerciseCD.self, and: ex.id){
                exercisesCD.append(exСD)
            }
        })
        
        workoutCD.exerciseCD = NSSet(array: exercisesCD)
        
        coreDataStack.saveContext(managedObjectContext)
    }
    
    //MARK: Read All Workouts with Exercises
    func readAllWorkouts() -> [WorkoutModelProtocol]? {
        guard let workoutsCD = getCoreDataAllEntities(withType: WorkoutCD.self) else {return nil}
        var result: [WorkoutModelProtocol] = [WorkoutModelProtocol]()
        
        for workout in workoutsCD {
            let muscleGroups = workout.muscleGroups.split(separator: "|").map { sub in
                MuscleGroup(rawValue: String(sub)) ?? .wholeBody
            }
            
            let exercises: [ExerciseModel] = transform(exercisesCD: workout.exerciseCD) ?? [ExerciseModel]()
            
            let workoutModel = WorkoutModel(
                title: workout.title,
                muscleGroups: muscleGroups,
                system: workout.system,
                exercises: exercises,
                id: workout.id
            )
            
            result.append(workoutModel)
        }
        return result
    }
    
    func readWorkout(id: UUID) -> WorkoutModelProtocol? {
        guard let exerciseCD = getCoreDataOneEntity(withType: WorkoutCD.self, and: id) else {return nil}
        let muscleGroups = exerciseCD.muscleGroups.split(separator: "|").map { sub in
            MuscleGroup(rawValue: String(sub)) ?? .wholeBody
        }
    
        let exercises: [ExerciseModel] = transform(exercisesCD: exerciseCD.exerciseCD) ?? [ExerciseModel]()
        
        let workoutModel = WorkoutModel(
            title: exerciseCD.title,
            muscleGroups: muscleGroups,
            system: exerciseCD.system,
            exercises: exercises,
            id: exerciseCD.id
        )
        
        return workoutModel
    }
    
    //MARK: Update workout with Exercises
    func update(workout: WorkoutModelProtocol) {
        guard let workoutCD = getCoreDataOneEntity(withType: WorkoutCD.self, and: workout.id) else {return}
        
        workoutCD.id = workout.id
        workoutCD.title = workout.title
        workoutCD.system = workout.system
        workoutCD.muscleGroups = workout.muscleGroups.map{$0.rawValue}.joined(separator: "|")
        workoutCD.exercisesCount = Int16(workout.exercises.count)
        
        var exercisesCD: [ExerciseCD] = [ExerciseCD]()
        
        workout.exercises.forEach({ ex in
            if let exСD = getCoreDataOneEntity(withType: ExerciseCD.self, and: ex.id){
                exercisesCD.append(exСD)
            }
        })
        
        workoutCD.exerciseCD = NSSet(array: exercisesCD)
        coreDataStack.saveContext(managedObjectContext)
    }
    

    //MARK: Delete workout
    func delete(workout: WorkoutModelProtocol) {
        guard let workoutCD = getCoreDataOneEntity(withType: WorkoutCD.self, and: workout.id) else {return}
        managedObjectContext.delete(workoutCD)
        coreDataStack.saveContext()
    }
    
    //MARK: Delete workout with Exercises
    func deleteAllWorkouts() {
        guard let allWorkouts = getCoreDataAllEntities(withType: WorkoutCD.self) else { return }
        for object in allWorkouts{
            managedObjectContext.delete(object)
        }
        
        coreDataStack.saveContext()
    }
}

extension CoreDataStorageManager: DataStorageExerciseManagerProtocol {
    //MARK: Create exercise
    func create(exercise: ExerciseModelProtocol) {
        guard let exerciseCD = NSEntityDescription.insertNewObject(forEntityName: "ExerciseCD", into: managedObjectContext) as? ExerciseCD else {return}
        
        exerciseCD.id = exercise.id
        exerciseCD.endImageName = exercise.endImageName
        exerciseCD.startImageName = exercise.startImageName
        exerciseCD.muscleGroup = exercise.muscleGroup.rawValue
        exerciseCD.descriptionText = exercise.description
        exerciseCD.title = exercise.title
        
        coreDataStack.saveContext(managedObjectContext)
    }
    
    //MARK: Read exercises
    func readAllExercises() -> [ExerciseModelProtocol]? {
        guard let exercisesCD = getCoreDataAllEntities(withType: ExerciseCD.self) else {return nil}
        var result: [ExerciseModelProtocol] = [ExerciseModelProtocol]()
        
        for exercise in exercisesCD {
            let muscleGroup = MuscleGroup(rawValue: exercise.muscleGroup) ?? .wholeBody
            
            let exerciseModel = ExerciseModel(
                title: exercise.title,
                muscleGroup: muscleGroup,
                description: exercise.descriptionText,
                startImageName: exercise.startImageName,
                endImageName: exercise.endImageName,
                id: exercise.id
            )
            
            result.append(exerciseModel)
        }
        return result
    }
    
    func readExercise(id: UUID) -> ExerciseModelProtocol? {
        guard let exerciseCD = getCoreDataOneEntity(withType: ExerciseCD.self, and: id) else {return nil}
        let muscleGroup = MuscleGroup(rawValue: exerciseCD.muscleGroup) ?? .wholeBody
        let exerciseModel = ExerciseModel(
            title: exerciseCD.title,
            muscleGroup: muscleGroup,
            description: exerciseCD.descriptionText,
            startImageName: exerciseCD.startImageName,
            endImageName: exerciseCD.endImageName,
            id: exerciseCD.id
        )
        return exerciseModel
        
    }
    
    //MARK: Update exercise
    func update(exercise: ExerciseModelProtocol) {
        guard let exerciseCD = getCoreDataOneEntity(withType: ExerciseCD.self, and: exercise.id) else {return}
        
        exerciseCD.id = exercise.id
        exerciseCD.endImageName = exercise.endImageName
        exerciseCD.startImageName = exercise.startImageName
        exerciseCD.muscleGroup = exercise.muscleGroup.rawValue
        exerciseCD.descriptionText = exercise.description
        exerciseCD.title = exercise.title
        
        coreDataStack.saveContext(managedObjectContext)
    }
    
    //MARK: Delete exercise
    func delete(exercise: ExerciseModelProtocol) {
        guard let exerciseCD = getCoreDataOneEntity(withType: ExerciseCD.self, and: exercise.id) else {return}
        managedObjectContext.delete(exerciseCD)
        coreDataStack.saveContext()
    }
    
    
}

//MARK: Helpers functions
extension CoreDataStorageManager {
    
    private func getCoreDataAllEntities<T: NSManagedObject>(withType entityType: T.Type) -> [T]? {
        let workoutFetch = T.fetchRequest()
        do {
            let results = try managedObjectContext.fetch(workoutFetch)
            return results as? [T]
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    private func getCoreDataOneEntity<T: NSManagedObject>(withType entityType: T.Type, and id: UUID) -> T? {
        let fetchRequest = T.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            return results.first as? T
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    private func transform(exercisesCD: NSSet?) -> [ExerciseModel]? {
        guard let exercisesCD = exercisesCD else { return nil }
        var exercises = [ExerciseModel]()
        
        for ex in exercisesCD {
            guard let ex = ex as? ExerciseCD else {return nil}
            exercises.append(
                ExerciseModel(
                    title: ex.title,
                    muscleGroup: MuscleGroup(rawValue: ex.muscleGroup) ?? .wholeBody,
                    description: ex.descriptionText,
                    startImageName: ex.startImageName,
                    endImageName: ex.endImageName,
                    id: ex.id
                )
            )
        }
        return exercises
    }
    
}
