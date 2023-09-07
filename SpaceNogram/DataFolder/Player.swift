//
//  Player.swift
//  SpaceNogram
//
//  Created by Duong Vu Thanh Ngoc on 29/08/2023.
//

import Foundation

struct Player: Identifiable, Codable{
    var id: Int
    var name: String
    var avatar: String
    var titleE: String
    var titleVN: String
    var stars: Int
    var achivementImage: String
    var user: Bool
    var starBadge1: Bool
    var starBadge2: Bool
    var starBadge3: Bool
    var starBadge4: Bool
    var playedBadge1: Bool
    var playedBadge2: Bool
    var playedBadge3: Bool
    var timeBadge1: Bool
    var timeBadge2: Bool
    var timeBadge3: Bool
    var totalGame: Int
    var highestStreakEasy: Int
    var highestStreakMedium: Int
    var highestStreakHard: Int
}
