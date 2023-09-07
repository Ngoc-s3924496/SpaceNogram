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

struct GameViewIphone14ProMax: View{
    @EnvironmentObject var gameData: GameDataStore
    @Binding var difficulty: String
    @Binding var language: String
    @State var gameGrid: ([[Character]], [Int], [Int], [Int], [Int])
    
    init(difficulty: Binding<String>, language: Binding<String>) {
        _difficulty = difficulty // Initialize the binding property
        _language = language
        let (grid, horizontalCounts, verticalCounts, startPoint, endPoint) = generateGameGrid(for: difficulty.wrappedValue)
        _gameGrid = State(initialValue: (grid, horizontalCounts, verticalCounts, startPoint, endPoint))
    }
    @State var win: Bool = false
    @State var showPause: Bool = false
    @State var showHowToPlay: Bool = false
    @AppStorage("health") private var health: Int = 10
    @AppStorage("level") private var level: Int = 1
    @AppStorage("musicSetting") private var music: Bool = true
    @AppStorage("soundSetting") private var sound: Bool = true
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer? = nil
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        ZStack{
            Image("GameBackground-Iphone")
                .resizable()
                .ignoresSafeArea()
            VStack{
                HStack{
                    Button{
                        if sound == true {
                            SoundEffectAudioManager.shared.playClickSound()
                        }
                        self.showPause.toggle()
                    } label: {
                        Image("PauseButton")
                            .resizable()
                            .frame(width: 85, height: 85)
                            .padding(.trailing, 50)
                    }
                    ZStack{
                        Image("BlueButton")
                            .resizable()
                            .frame(width: 115, height: 70)
                        HStack{
                            Image("Bomb")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text(difficulty == "Easy" ? "8" : (difficulty == "Medium" ? "12" : "20"))
                                .font(.custom("Inter-Bold", size: 24))
                            
                        }.padding(.top, -5)
                    }
                    ZStack{
                        Image("BlueButton")
                            .resizable()
                            .frame(width: 115, height: 70)
                        HStack{
                            Image("Heart")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text(String(health))
                                .font(.custom("Inter-Bold", size: 24))
                            
                        }.padding(.top, -5)
                    }
                }.padding(.bottom, 80)
                Text(language == "English" ? "Level \(String(level))" : "Vòng \(String(level))")
                    .font(.custom("Inter-ExtraBold", size: 27))
                
                    .padding(.bottom, 20)
                ZStack{
                    Image("TileBackground")
                        .resizable()
                        .frame(width: 390, height: 410)
                        .cornerRadius(15)
                    if difficulty == "Easy"{
                        VStack(spacing: 3){
                            ForEach(0..<7){row in
                                if row == 0{
                                    HStack(spacing: 3){
                                        ForEach(0..<7){ column in
                                            if column == 0{
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 50)
                                            } else{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 50, height: 50)
                                                    Text(String(gameGrid.2[column-1]))
                                                        .font(.custom("Inter-Bold", size: 22))
                                                    
                                                        .padding(.bottom, 13)
                                                }
                                            }
                                        }
                                    }.padding(.bottom, -10)
                                } else{
                                    HStack(spacing: 3){
                                        ForEach(0..<7){column in
                                            if column == 0{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 50, height: 50)
                                                    Text(String(gameGrid.1[row-1]))
                                                        .font(.custom("Inter-Bold", size: 22))
                                                    
                                                        .padding(.bottom, 13)
                                                }
                                            } else{
                                                if(gameGrid.0[row-1][column-1] == "e" || gameGrid.0[row-1][column-1] == "c"){
                                                    Iphone14ProMaxChosenTileEasy(win: $win, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if(gameGrid.0[row-1][column-1] == "b" || gameGrid.0[row-1][column-1] == "B"){
                                                    Iphone14ProMaxBombTileEasy(health: $health, level: $level, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if (gameGrid.0[row-1][column-1] == "o" || (gameGrid.0[row-1][column-1] == "x")){
                                                    Iphone14ProMaxStartEndTileEasy()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }.padding(.bottom, 20)
                            .padding(.leading, -10)
                    } else if difficulty == "Medium"{
                        VStack(spacing: 1){
                            ForEach(0..<9){ row in
                                if row == 0{
                                    HStack(spacing: 3){
                                        ForEach(0..<9){column in
                                            if column == 0{
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 38)
                                            } else{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 38, height: 38)
                                                    Text(String(gameGrid.2[column-1]))
                                                        .font(.custom("Inter-Bold", size: 16))
                                                    
                                                        .padding(.bottom, 7)
                                                }
                                            }
                                        }
                                    }.padding(.bottom, -20)
                                } else{
                                    HStack(spacing: 3){
                                        ForEach(0..<9){column in
                                            if column == 0{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 38, height: 38)
                                                    Text(String(gameGrid.1[row-1]))
                                                        .font(.custom("Inter-Bold", size: 16))
                                                    
                                                        .padding(.bottom, 7)
                                                }
                                            } else{
                                                if(gameGrid.0[row-1][column-1] == "e" || gameGrid.0[row-1][column-1] == "c"){
                                                    Iphone14ProMaxChosenTileMedium(win: $win, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if(gameGrid.0[row-1][column-1] == "b" || gameGrid.0[row-1][column-1] == "B"){
                                                    Iphone14ProMaxBombTileMedium(health: $health, level: $level, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if (gameGrid.0[row-1][column-1] == "o" || (gameGrid.0[row-1][column-1] == "x")){
                                                    Iphone14ProMaxStartEndTileMedium()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }.padding(.bottom, 24)
                            .padding(.leading, -10)
                    } else if difficulty == "Hard"{
                        VStack(spacing: 1){
                            ForEach(0..<11){row in
                                if row == 0{
                                    HStack(spacing: 2){
                                        ForEach(0..<11){column in
                                            if column == 0{
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 32)
                                            } else{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 32, height: 32)
                                                    Text(String(gameGrid.2[column-1]))
                                                        .font(.custom("Inter-Bold", size: 13))
                                                    
                                                        .padding(.bottom, 5)
                                                }
                                            }
                                        }
                                    }.padding(.bottom, -10)
                                } else{
                                    HStack(spacing: 2){
                                        ForEach(0..<11){column in
                                            if column == 0{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 32, height: 32)
                                                    Text(String(gameGrid.1[row-1]))
                                                        .font(.custom("Inter-Bold", size: 12))
                                                    
                                                        .padding(.bottom, 5)
                                                }
                                            } else{
                                                if(gameGrid.0[row-1][column-1] == "e" || gameGrid.0[row-1][column-1] == "c"){
                                                    Iphone14ProMaxChosenTileHard(win: $win, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if(gameGrid.0[row-1][column-1] == "b" || gameGrid.0[row-1][column-1] == "B"){
                                                    Iphone14ProMaxBombTileHard(health: $health, level: $level, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if (gameGrid.0[row-1][column-1] == "o" || (gameGrid.0[row-1][column-1] == "x")){
                                                    Iphone14ProMaxStartEndTileHard()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }.padding(.bottom, 24)
                            .padding(.leading, -10)
                    }
                    
                }
                HStack{
                    ZStack{
                        Image("Time")
                            .resizable()
                            .frame(width: 135, height: 60)
                        HStack{
                            Image("Clock")
                                .resizable()
                                .frame(width: 22, height: 27)
                            Text(formatTime(elapsedTime))
                                .font(.custom("Inter-Medium", size: 20))
                            
                        }
                        Image("Astronaut-Iphone")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .offset(x: 5, y: -58)
                    }.padding(.trailing, 140)
                        .onAppear{
                            startTimer()
                        }
                    Button{
                        if sound == true {
                            SoundEffectAudioManager.shared.playClickSound()
                        }
                        self.showHowToPlay.toggle()
                    } label:{
                        Image("HowToPlayButton")
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                }.padding(.top, 100)
            }
            if self.showPause{
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                PauseViewIphone14ProMax(language: $language, difficulty: $difficulty, showPause: $showPause, win: $win, gameGrid: $gameGrid, health: $health, level: $level, startTimer: startTimer, resetTimer: resetTimer, updateUserPlayer: updateUserPlayer)
                    .environmentObject(GameDataStore())
                    .onAppear{
                        stopTimer()
                    }
            }
            if self.win{
                Color.black.opacity(0.6).edgesIgnoringSafeArea(.all)
                WinViewIphone14ProMax(language: $language, difficulty: $difficulty, level: $level, health: $health, win: $win, gameGrid: $gameGrid, elapsedTime: $elapsedTime, resetTimer: resetTimer, updateUserPlayer: updateUserPlayer, updateTimeBadge: updateTimeBadge)
                    .environmentObject(GameDataStore())
                    .onAppear{
                        stopTimer()
                    }
            }
            if health == 0{
                Color.black.opacity(0.6).edgesIgnoringSafeArea(.all)
                LoseViewIphone14ProMax(language: $language, difficulty: $difficulty, level: $level, health: $health, win: $win, gameGrid: $gameGrid, resetTimer: resetTimer, updateUserPlayer: updateUserPlayer)
                    .environmentObject(GameDataStore())
                    .onAppear{
                        stopTimer()
                    }
            }
            if self.showHowToPlay{
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                HowToPlayViewIphone14ProMax(showHowToPlay: $showHowToPlay, language: $language)
            }
        }.onAppear{
            if level == 1{
                gameData.userPlayer!.totalGame += 1
                gameData.saveDataToFile()
            }
            if music == true{
                BackgroundAudioManager.shared.stopMainMenuMusic()
                BackgroundAudioManager.shared.playGameViewMusic()
            }
        }
    }
    func formatTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                elapsedTime += 1
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        elapsedTime = 0
        startTimer()
    }
}
