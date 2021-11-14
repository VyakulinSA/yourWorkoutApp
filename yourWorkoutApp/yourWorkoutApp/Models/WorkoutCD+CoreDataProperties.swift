//
//  WorkoutCD+CoreDataProperties.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 07.11.2021.
//
//

import Foundation
import CoreData


extension WorkoutCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutCD> {
        return NSFetchRequest<WorkoutCD>(entityName: "WorkoutCD")
    }

    @NSManaged public var title: String
    @NSManaged public var exercisesCount: Int16
    @NSManaged public var muscleGroups: String
    @NSManaged public var system: Bool
    @NSManaged public var id: UUID
    @NSManaged public var exerciseCD: NSSet?
    @NSManaged public var exercisesId: String
    @NSManaged public var createdDate: Date

}

// MARK: Generated accessors for exerciseCD
extension WorkoutCD {

    @objc(addExerciseCDObject:)
    @NSManaged public func addToExerciseCD(_ value: ExerciseCD)

    @objc(removeExerciseCDObject:)
    @NSManaged public func removeFromExerciseCD(_ value: ExerciseCD)

    @objc(addExerciseCD:)
    @NSManaged public func addToExerciseCD(_ values: NSSet)

    @objc(removeExerciseCD:)
    @NSManaged public func removeFromExerciseCD(_ values: NSSet)

}

extension WorkoutCD : Identifiable {

}
