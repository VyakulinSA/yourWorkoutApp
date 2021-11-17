//
//  Standings.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 15.11.2021.
//

import Foundation

// MARK: - Standings
struct DataStandings: Codable {
    let status: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let name, abbreviation, seasonDisplay: String
    let season: Int
    let standings: [Standing]
}

// MARK: - Standing
struct Standing: Codable {
    let team: Team
    let note: Note?
    let stats: [Stat]
}

// MARK: - Note
struct Note: Codable {
    let rank: Int
}

// MARK: - Team
struct Team: Codable {
    let id, uid, location, name: String
    let abbreviation, displayName, shortDisplayName: String
    let isActive: Bool
    let logos: [Logo]
}

// MARK: - Logo
struct Logo: Codable {
    let href: String
}

struct Stat: Codable {
    let name: String
    let value: Int?
}

