/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Duong Vu Thanh Ngoc
 ID: s3924496 (e.g. 1234567)
 Created  date: 15/08/2023
 Last modified: 6/9/2023
 Acknowledgement: Flaticon.com, Minesweeper Genius
 */

import SwiftUI

func updateUserPlayer(levelReducer: Int, gameData: GameDataStore, level: Int, difficulty: String){
    if difficulty == "Easy" {
        if gameData.userPlayer!.highestStreakEasy < (level - levelReducer) {
            gameData.userPlayer!.highestStreakEasy = level - levelReducer
        }
        // Unlock star badge if stars point the limit
        if (level - levelReducer) * 1 >= 20 && (level - levelReducer) * 1 <= 39{
            gameData.userPlayer!.starBadge2 = true
        }
        if (level - levelReducer) * 1 >= 40 && (level - levelReducer) * 1 <= 60 {
            gameData.userPlayer!.starBadge3 = true
        }
        if (level - levelReducer) * 1 > 60{
            gameData.userPlayer!.starBadge4 = true
        }
        // Update the stars data using the formula
        if gameData.userPlayer!.stars < (level - levelReducer) * 1 {
            gameData.userPlayer!.stars = (level - levelReducer) * 1
        }
    } else if difficulty == "Medium" {
        if gameData.userPlayer!.highestStreakMedium < (level - levelReducer) {
            gameData.userPlayer!.highestStreakMedium = level - levelReducer
        }
        // Unlock star badge if stars point the limit
        if (level - levelReducer) * 2 >= 20 && (level - levelReducer) * 2 <= 39{
            gameData.userPlayer!.starBadge2 = true
        }
        if (level - levelReducer) * 2 >= 40 && (level - levelReducer) * 2 <= 60 {
            gameData.userPlayer!.starBadge3 = true
        }
        if (level - levelReducer) * 2 > 60{
            gameData.userPlayer!.starBadge4 = true
        }
        // Update the stars data using the formula
        if gameData.userPlayer!.stars < (level - levelReducer) * 2 {
            gameData.userPlayer!.stars = (level - levelReducer) * 2
        }
    } else if difficulty == "Hard" {
        if gameData.userPlayer!.highestStreakHard < (level - levelReducer) {
            gameData.userPlayer!.highestStreakHard = level - levelReducer
        }
        // Unlock star badge if stars point the limit
        if (level - levelReducer) * 3 >= 20 && (level - levelReducer) * 3 <= 39{
            gameData.userPlayer!.starBadge2 = true
        }
        if (level - levelReducer) * 3 >= 40 && (level - levelReducer) * 3 <= 60 {
            gameData.userPlayer!.starBadge3 = true
        }
        if (level - levelReducer) * 3 > 60{
            gameData.userPlayer!.starBadge4 = true
        }
        // Update the stars data using the formula
        if gameData.userPlayer!.stars < (level - levelReducer) * 3 {
            gameData.userPlayer!.stars = (level - levelReducer) * 3
        }
    }
    // Update the title based on the unlock star badge
    if gameData.userPlayer!.starBadge4 == true{
        gameData.userPlayer!.achivementImage = "SuperGold"
        gameData.userPlayer!.titleE = "Super Gold Triumph"
        gameData.userPlayer!.titleVN = "Chiến Thắng Siêu Vàng"
    } else if gameData.userPlayer!.starBadge3 == true {
        gameData.userPlayer!.achivementImage = "Gold"
        gameData.userPlayer!.titleE = "Gold Triumph"
        gameData.userPlayer!.titleVN = "Chiến Thắng Vàng"
    } else if gameData.userPlayer!.starBadge2 == true{
        gameData.userPlayer!.achivementImage = "Silver"
        gameData.userPlayer!.titleE = "Silver Achivement"
        gameData.userPlayer!.titleVN = "Thành Tích Bạc"
    }
    gameData.saveDataToFile()
}

func updateTimeBadge(elapsedTime: TimeInterval, gameData: GameDataStore) {
    // Unlock time badge base on time to complete a level
    if Int(elapsedTime) <= 90{
        gameData.userPlayer!.timeBadge1 = true
    }
    if Int(elapsedTime) <= 60{
        gameData.userPlayer!.timeBadge2 = true
    }
    if Int(elapsedTime) <= 10{
        gameData.userPlayer!.timeBadge3 = true
    }
    gameData.saveDataToFile()
}
