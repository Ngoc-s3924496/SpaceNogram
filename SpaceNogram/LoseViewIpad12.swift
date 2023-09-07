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

struct LoseViewIpad12: View{
    @EnvironmentObject var gameData: GameDataStore
    @Binding var language: String
    @Binding var difficulty: String
    @Binding var level: Int
    @Binding var health: Int
    @Binding var win: Bool
    @Binding var gameGrid: ([[Character]], [Int], [Int], [Int], [Int])
    @AppStorage("soundSetting") private var sound: Bool = true
    var resetTimer: () -> Void
    var updateUserPlayer: (Int, GameDataStore, Int, String) -> Void
    @Environment(\.presentationMode) var presentationMode
    let difficultyStars: [String: Int] = [
        "Easy": 1,
        "Medium": 2,
        "Hard": 3
    ]
    var body: some View{
        GeometryReader{ geometry in
            ZStack{
                Image(language == "English" ? "LevelFailedBackground" : "ThatBaiBackground")
                    .resizable()
                    .frame(width: 850, height: 850)
                VStack{
                    ZStack{
                        Image("LevelButton")
                            .resizable()
                            .frame(width: 255, height: 150)
                        Text(language == "English" ? "Level \(String(level))" : "Vòng \(String(level))")
                            .font(.custom("Inter-Bold", size: 38))
                        
                    }
                    if difficulty == "Easy"{
                        Image("LostStar")
                            .resizable()
                            .frame(width: 141, height: 141)
                    } else if difficulty == "Medium"{
                        HStack{
                            Image("LostStar" )
                                .resizable()
                                .frame(width: 141, height: 141)
                            Image("LostStar" )
                                .resizable()
                                .frame(width: 141, height: 141)
                            
                        }
                    } else if difficulty == "Hard"{
                        HStack{
                            Image("LostStar" )
                                .resizable()
                                .frame(width: 111, height: 111)
                                .offset(y: 20)
                            Image("LostStar" )
                                .resizable()
                                .frame(width: 141, height: 141)
                            Image("LostStar" )
                                .resizable()
                                .frame(width: 111, height: 111)
                                .offset(y: 20)
                        }
                    }
                    let totalStars = (difficultyStars[difficulty] ?? 0) * (level - 1)
                    Text("Total Star: \(String(totalStars))")
                        .font(.custom("Inter-ExtraBold", size: 42))
                        .foregroundColor(Color(red: 1.00, green: 0.71, blue: 0.13))
                        .shadow(color: Color.black.opacity(0.5), radius: 3, x: 0, y: 3)
                        .padding(.top, 20)
                    HStack{
                        Button{
                            if sound == true {
                                SoundEffectAudioManager.shared.playClickSound()
                            }
                            updateUserPlayer(1, gameData, level, difficulty)
                            health = 10
                            level = 1
                            presentationMode.wrappedValue.dismiss()
                        }
                    label: {
                        Image("ExitIcon")
                            .resizable()
                            .frame(width: 135, height: 135)
                    }
                        Button{
                            if sound == true {
                                SoundEffectAudioManager.shared.playClickSound()
                            }
                            updateUserPlayer(1, gameData, level, difficulty)
                            let (grid, horizontalCounts, verticalCounts, startPoint, endPoint) = generateGameGrid(for: difficulty)
                            gameGrid = (grid, horizontalCounts, verticalCounts, startPoint, endPoint)
                            level = 1
                            health = 10
                            gameData.userPlayer!.totalGame += 1
                            gameData.saveDataToFile()
                            resetTimer()
                        } label: {
                            Image(language == "English" ? "RestartButton" : "ChoiLaiButton")
                                .resizable()
                                .frame(width: 235, height: 130)
                        }
                    }.padding(.bottom, -100)
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
                .onAppear{
                    if sound == true {
                        SoundEffectAudioManager.shared.playLevelFailedSound()
                    }
                }
        }
    }
}
