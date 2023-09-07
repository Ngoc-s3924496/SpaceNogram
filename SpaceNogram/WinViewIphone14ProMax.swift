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

struct WinViewIphone14ProMax: View{
    @EnvironmentObject var gameData: GameDataStore
    @Binding var language: String
    @Binding var difficulty: String
    @Binding var level: Int
    @Binding var health: Int
    @Binding var win: Bool
    @Binding var gameGrid: ([[Character]], [Int], [Int], [Int], [Int])
    @Binding var elapsedTime: TimeInterval
    @State var star1Appear: Bool = false
    @State var star2Appear: Bool = false
    @State var star3Appear: Bool = false
    @AppStorage("soundSetting") private var sound: Bool = true
    var resetTimer: () -> Void
    var updateUserPlayer: (Int, GameDataStore, Int, String) -> Void
    var updateTimeBadge: (TimeInterval, GameDataStore) -> Void
    @Environment(\.presentationMode) var presentationMode
    let difficultyStars: [String: Int] = [
        "Easy": 1,
        "Medium": 2,
        "Hard": 3
    ]
    var body: some View{
        GeometryReader{ geometry in
            ZStack{
                Image(language == "English" ? "LevelCompletedBackground" : "HoanThanhBackground")
                    .resizable()
                    .frame(width: 400, height: 420)
                VStack{
                    ZStack{
                        Image("LevelButton")
                            .resizable()
                            .frame(width: 145, height: 60)
                        Text(language == "English" ? "Level \(String(level))" : "Vòng \(String(level))")
                            .font(.custom("Inter-Bold", size: 24))
                        
                    }
                    if difficulty == "Easy"{
                        Image(star1Appear == true ? "YellowStar" : "LostStar")
                            .resizable()
                            .frame(width: 65, height: 65)
                            .onAppear {
                                // Start a timer to change the state after 0.5 seconds
                                Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { _ in
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playWinningStarsSound()
                                    }
                                }
                                Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { _ in
                                    star1Appear.toggle() // Toggle the state
                                }
                            }
                    } else if difficulty == "Medium"{
                        HStack{
                            Image(star1Appear == true ? "YellowStar" : "LostStar" )
                                .resizable()
                                .frame(width: 65, height: 65)
                                .onAppear {
                                    // Start a timer to change the state after 0.5 seconds
                                    Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { _ in
                                        if sound == true {
                                            SoundEffectAudioManager.shared.playWinningStarsSound()
                                        }
                                    }
                                    Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { _ in
                                        star1Appear.toggle() // Toggle the state
                                    }
                                }
                            Image(star2Appear == true ? "YellowStar" : "LostStar" )
                                .resizable()
                                .frame(width: 65, height: 65)
                                .onAppear {
                                    // Start a timer to change the state after 0.5 seconds
                                    Timer.scheduledTimer(withTimeInterval: 1.00, repeats: false) { _ in
                                        if sound == true {
                                            SoundEffectAudioManager.shared.playWinningStarsSound()
                                        }
                                    }
                                    Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                                        star2Appear.toggle() // Toggle the state
                                    }
                                }
                        }
                    } else if difficulty == "Hard"{
                        HStack{
                            Image(star2Appear == true ? "YellowStar" : "LostStar" )
                                .resizable()
                                .frame(width: 52, height: 52)
                                .onAppear {
                                    // Start a timer to change the state after 0.5 seconds
                                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                                        if sound == true {
                                            SoundEffectAudioManager.shared.playWinningStarsSound()
                                        }
                                    }
                                    Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                                        star2Appear.toggle() // Toggle the state
                                    }
                                }
                                .offset(y: 15)
                            Image(star1Appear == true ? "YellowStar" : "LostStar" )
                                .resizable()
                                .frame(width: 65, height: 65)
                                .onAppear {
                                    // Start a timer to change the state after 0.5 seconds
                                    Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { _ in
                                        if sound == true {
                                            SoundEffectAudioManager.shared.playWinningStarsSound()
                                        }
                                    }
                                    Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { _ in
                                        star1Appear.toggle() // Toggle the state
                                    }
                                }
                            Image(star3Appear == true ? "YellowStar" : "LostStar" )
                                .resizable()
                                .frame(width: 52, height: 52)
                                .onAppear {
                                    // Start a timer to change the state after 0.5 seconds
                                    Timer.scheduledTimer(withTimeInterval: 1.75, repeats: false) { _ in
                                        if sound == true {
                                            SoundEffectAudioManager.shared.playWinningStarsSound()
                                        }
                                    }
                                    Timer.scheduledTimer(withTimeInterval: 2.25, repeats: false) { _ in
                                        star3Appear.toggle() // Toggle the state
                                    }
                                }
                                .offset(y: 15)
                        }
                    }
                    let totalStars = (difficultyStars[difficulty] ?? 0) * level
                    Text("Total Star: \(String(totalStars))")
                        .font(.custom("Inter-ExtraBold", size: 26))
                        .foregroundColor(Color(red: 1.00, green: 0.71, blue: 0.13))
                        .shadow(color: Color.black.opacity(0.5), radius: 3, x: 0, y: 3)
                        .padding(.top, 10)
                    HStack{
                        Button{
                            if sound == true {
                                SoundEffectAudioManager.shared.playClickSound()
                            }
                            updateUserPlayer(0, gameData, level, difficulty)
                            health = 10
                            level = 1
                            presentationMode.wrappedValue.dismiss()
                        }
                    label: {
                        Image("ExitIcon")
                            .resizable()
                            .frame(width: 65, height: 65)
                    }
                        Button{
                            if sound == true {
                                SoundEffectAudioManager.shared.playClickSound()
                            }
                            level += 1
                            let (grid, horizontalCounts, verticalCounts, startPoint, endPoint) = generateGameGrid(for: difficulty)
                            gameGrid = (grid, horizontalCounts, verticalCounts, startPoint, endPoint)
                            resetTimer()
                            win = false
                        } label: {
                            Image(language == "English" ? "NextButton" : "TiepTucButton")
                                .resizable()
                                .frame(width: 145, height: 65)
                        }
                    }.padding(.bottom, -60)
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
                .onAppear{
                    if sound == true {
                        SoundEffectAudioManager.shared.playLevelCompletedSound()
                    }
                    updateTimeBadge(elapsedTime, gameData)
                }
        }
    }
}
