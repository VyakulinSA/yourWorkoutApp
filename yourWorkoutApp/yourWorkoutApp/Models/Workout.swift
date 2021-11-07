//
//  Workout.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import Foundation

protocol WorkoutModelProtocol {
    var title: String { get }
    var muscleGroups: [MuscleGroup] { get }
    var system: Bool { get }
    var exercises: [ExerciseModelProtocol]? { get }
    var id: UUID { get }
}

struct WorkoutModel: WorkoutModelProtocol {
    let title: String
    let muscleGroups: [MuscleGroup]
    let system: Bool
    let exercises: [ExerciseModelProtocol]?
    let id: UUID
}
