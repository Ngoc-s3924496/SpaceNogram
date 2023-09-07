//
//  PlayerDataStore.swift
//  SpaceNogram
//
//  Created by Duong Vu Thanh Ngoc on 29/08/2023.
//

import SwiftUI
import Combine

class GameDataStore: ObservableObject{
    @Published var players: [Player]
    @Published var userPlayer: Player? {
        didSet {
            if let updatedUserPlayer = userPlayer {
                if let index = players.firstIndex(where: { $0.id == updatedUserPlayer.id }) {
                    players.remove(at: index) // Remove the old userPlayer
                    players.insert(updatedUserPlayer, at: index) // Insert the updated userPlayer
                }
            }
        }
    }
    
    init() {
        players = decodeJsonFromJsonFile(jsonFile: "Data.json")
        userPlayer = players.first(where: { $0.user == true })
    }
    
    func incrementAvatarNumber() {
        if let currentNumber = extractNumber(from: userPlayer!.avatar) {
            let newNumber = currentNumber + 1
            let finalNumber = max(1, min(newNumber, 11))
            let newAvatarName = "User\(finalNumber)"
            userPlayer!.avatar = newAvatarName
            saveDataToFile()
        }
    }
    
    func decrementAvatarNumber() {
        if let currentNumber = extractNumber(from: userPlayer!.avatar) {
            let newNumber = currentNumber - 1
            let finalNumber = min(max(1, newNumber), 11)
            let newAvatarName = "User\(finalNumber)"
            userPlayer!.avatar = newAvatarName
            saveDataToFile()
        }
    }
    
    
    func extractNumber(from avatar: String) -> Int? {
        let pattern = "User(\\d+)"
        if let range = avatar.range(of: pattern, options: .regularExpression) {
            let numberPart = avatar[range].dropFirst(4)
            return Int(numberPart)
        }
        return nil
    }
    
    func saveDataToFile() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(players)
            if let fileURL = Bundle.main.url(forResource: "Data", withExtension: "json") {
                try data.write(to: fileURL)
            }
        } catch {
            print("Error saving data to JSON file: \(error)")
        }
    }
}


func decodeJsonFromJsonFile(jsonFile: String) -> [Player] {
    if let file = Bundle.main.url(forResource: jsonFile, withExtension: nil){
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Player].self, from: data)
                return decoded
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else {
        fatalError("Couldn't load \(jsonFile) file")
    }
    return [ ] as [Player]
}
