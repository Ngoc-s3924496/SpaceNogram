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

import Foundation

func updatePlayedBadge(gameData: GameDataStore) {
    // If user have played more than 20 games, unlock the first played badge
    if gameData.userPlayer!.totalGame >= 20{
        gameData.userPlayer!.playedBadge1 = true
    }
    // If user have played more than 50 games, unlock the second played badge
    if gameData.userPlayer!.totalGame >= 50{
        gameData.userPlayer!.playedBadge2 = true
    }
    // If user have played more than 100 games, unlock the third played badge
    if gameData.userPlayer!.totalGame >= 100{
        gameData.userPlayer!.playedBadge2 = true
    }
    gameData.saveDataToFile()
}
