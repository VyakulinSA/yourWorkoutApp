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
    var title: String { get set }
    var muscleGroup: MuscleGroup { get set }
    var description: String { get set }
    var startImagePath: String? { get set }
    var endImagePath: String? { get set }
    var id: UUID { get set }
}

struct ExerciseModel: ExerciseModelProtocol {
    var title: String
    var muscleGroup: MuscleGroup
    var description: String
    var startImagePath: String?
    var endImagePath: String?
    var id: UUID
}
