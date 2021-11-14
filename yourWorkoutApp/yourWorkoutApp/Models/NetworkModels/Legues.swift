//
//  Leagues.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 14.11.2021.
//

import Foundation

// MARK: - Leagues
struct Leagues: Codable {
    let status: Bool
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id, name, slug, abbr: String
    let logos: Logos
}

// MARK: - Logos
struct Logos: Codable {
    let light: String
    let dark: String
}
