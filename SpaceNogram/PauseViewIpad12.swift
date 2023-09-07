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

struct PauseViewIpad12: View{
    @EnvironmentObject var gameData: GameDataStore
    @Binding var language: String
    @Binding var difficulty: String
    @Binding var showPause: Bool
    @Binding var win: Bool
    @Binding var gameGrid: ([[Character]], [Int], [Int], [Int], [Int])
    @Binding var health: Int
    @Binding var level: Int
    @AppStorage("soundSetting") private var sound: Bool = true
    var startTimer: () -> Void
    var resetTimer: () -> Void
    var updateUserPlayer: (Int, GameDataStore, Int, String) -> Void
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        GeometryReader{ geometry in
            ZStack{
                Image(language == "English" ? "PausedBackground-Iphone" : "TamDungBackground-Iphone")
                    .resizable()
                    .frame(width: 800, height: 700)
                VStack{
                    HStack{
                        Button{
                            if sound == true {
                                SoundEffectAudioManager.shared.playClickSound()
                            }
                            let (grid, horizontalCounts, verticalCounts, startPoint, endPoint) = generateGameGrid(for: difficulty)
                            gameGrid = (grid, horizontalCounts, verticalCounts, startPoint, endPoint)
                            health = 10
                            level = 1
                            resetTimer()
                            showPause.toggle()
                        } label: {
                            Image("RestartIcon")
                                .resizable()
                                .frame(width: 180, height: 180)
                        }
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
                            .frame(width: 180, height: 180)
                    }
                    }
                    Button{
                        if sound == true {
                            SoundEffectAudioManager.shared.playClickSound()
                        }
                        showPause.toggle()
                        startTimer()
                    } label: {
                        Image(language == "English" ? "ResumeButton" : "ResumeVNButton")
                            .resizable()
                            .frame(width: 356, height: 130)
                            .padding(.bottom, -85)
                    }
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
