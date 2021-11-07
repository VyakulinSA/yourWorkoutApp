//
//  Exercise.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import Foundation

enum MuscleGroup: String, CaseIterable{
    case wholeBody = "Whole Body"
    case shoulders = "Shoulders"
    case biceps = "Biceps"
    case chest = "Chest"
    case triceps = "Triceps"
    case back = "Back"
    case abs = "Abs"
    case legs = "Legs"
}

protocol ExerciseModelProtocol {
    var title: String { get }
    var muscleGroup: MuscleGroup { get }
    var description: String { get }
    var startImage: Data? { get }
    var endImage: Data? { get }
    var workout: WorkoutModelProtocol? { get }
    var id: UUID { get }
}

struct ExerciseModel: ExerciseModelProtocol {
    let title: String
    let muscleGroup: MuscleGroup
    let description: String
    let startImage: Data?
    let endImage: Data?
    let workout: WorkoutModelProtocol?
    let id: UUID
}
