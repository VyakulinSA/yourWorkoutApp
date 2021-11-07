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
    func update(workout: WorkoutModelProtocol)
    func delete(workout: WorkoutModelProtocol)
    func deleteAllWorkouts()
    
    func add(exercises: [ExerciseModelProtocol]?, for workout: WorkoutModelProtocol)
    func getExercises(for workout: WorkoutModelProtocol) -> [ExerciseModelProtocol]?
}

protocol DataStorageExerciseManagerProtocol: AnyObject {
    func create(exercise: ExerciseModelProtocol)
    func readAllExercises() -> [ExerciseModelProtocol]?
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
    func create(workout: WorkoutModelProtocol) {
        guard let workoutEntity = NSEntityDescription.insertNewObject(forEntityName: "WorkoutCD", into: managedObjectContext) as? WorkoutCD else {return}
        workoutEntity.id = workout.id
        workoutEntity.title = workout.title
        workoutEntity.system = workout.system
        workoutEntity.muscleGroups = workout.muscleGroups.map{$0.rawValue}.joined(separator: "|")
        workoutEntity.exercisesCount = Int16(workout.exercises?.count ?? 0)
        
        coreDataStack.saveContext(managedObjectContext)
    }
    
    func readAllWorkouts() -> [WorkoutModelProtocol]? {
        guard let workoutsCD = readWorkoutsCD() else {return nil}
        var result: [WorkoutModelProtocol] = [WorkoutModelProtocol]()
        
        for workout in workoutsCD {
            let muscleGroups = workout.muscleGroups.split(separator: "|").map { sub in
                MuscleGroup(rawValue: String(sub)) ?? .wholeBody
            }
            
//            let exerciseModels = workout.exerciseCD?.map({ exercise in
//                let ex = exercise as? ExerciseCD
//                ExerciseModel(
//                    title: ex?.title,
//                    muscleGroup: ex?.muscleGroup,
//                    description: <#T##String#>,
//                    startImage: <#T##Data?#>,
//                    endImage: <#T##Data?#>,
//                    workout: <#T##WorkoutModelProtocol?#>,
//                    id: <#T##UUID#>)
//            })
            
            let workoutModel = WorkoutModel(
                title: workout.title,
                muscleGroups: muscleGroups,
                system: workout.system,
                exercises: nil,
                id: workout.id)
            result.append(workoutModel)
        }
        return result
    }
    
    private func readWorkoutsCD() -> [WorkoutCD]? {
        let workoutFetch: NSFetchRequest<WorkoutCD> = WorkoutCD.fetchRequest()
        do {
            let results = try managedObjectContext.fetch(workoutFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    func update(workout: WorkoutModelProtocol) {
        print(#function)
    }
    
    func delete(workout: WorkoutModelProtocol) {
        print(#function)
    }
    
    func deleteAllWorkouts() {
        guard let allWorkouts = readWorkoutsCD() else { return }
        for object in allWorkouts{
            managedObjectContext.delete(object)
        }
        
        coreDataStack.saveContext()
    }
    
    func add(exercises: [ExerciseModelProtocol]?, for workout: WorkoutModelProtocol) {
        print(#function)
    }
    
    func getExercises(for workout: WorkoutModelProtocol) -> [ExerciseModelProtocol]? {
        print(#function)
        return nil
    }
    

}

extension CoreDataStorageManager: DataStorageExerciseManagerProtocol {
    func create(exercise: ExerciseModelProtocol) {
        print(#function)
    }
    
    func readAllExercises() -> [ExerciseModelProtocol]? {
        print(#function)
        return nil
    }
    
    func update(exercise: ExerciseModelProtocol) {
        print(#function)
    }
    
    func delete(exercise: ExerciseModelProtocol) {
        print(#function)
    }
    
    
}
