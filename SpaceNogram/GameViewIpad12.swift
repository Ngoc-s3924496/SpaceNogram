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

struct GameViewIpad12: View{
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
            Image("GameBackground-Ipad")
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
                            .frame(width: 125, height: 125)
                            .padding(.trailing, 250)
                    }
                    ZStack{
                        Image("BlueButton")
                            .resizable()
                            .frame(width: 215, height: 110)
                        HStack{
                            Image("Bomb")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Text(difficulty == "Easy" ? "8" : (difficulty == "Medium" ? "12" : "20"))
                                .font(.custom("Inter-Bold", size: 40))
                            
                        }.padding(.top, -5)
                    }
                    ZStack{
                        Image("BlueButton")
                            .resizable()
                            .frame(width: 215, height: 110)
                        HStack{
                            Image("Heart")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Text(String(health))
                                .font(.custom("Inter-Bold", size: 40))
                            
                        }.padding(.top, -5)
                    }
                }.padding(.bottom, -10)
                    .padding(.top, 20)
                Text(language == "English" ? "Level \(String(level))" : "Vòng \(String(level))")
                    .font(.custom("Inter-ExtraBold", size: 48))
                
                    .padding(.bottom, -20)
                ZStack{
                    Image("TileBackground")
                        .resizable()
                        .frame(width: 900, height: 880)
                        .cornerRadius(15)
                    if difficulty == "Easy"{
                        VStack(spacing: 3){
                            ForEach(0..<7){row in
                                if row == 0{
                                    HStack(spacing: 3){
                                        ForEach(0..<7){column in
                                            if column == 0{
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 110)
                                            } else{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 110, height: 110)
                                                    Text(String(gameGrid.2[column-1]))
                                                        .font(.custom("Inter-Bold", size: 48))
                                                    
                                                        .padding(.bottom, 13)
                                                }
                                            }
                                        }
                                    }.padding(.bottom, -50)
                                } else{
                                    HStack(spacing: 3){
                                        ForEach(0..<7){column in
                                            if column == 0{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 110, height: 110)
                                                    Text(String(gameGrid.1[row-1]))
                                                        .font(.custom("Inter-Bold", size: 48))
                                                    
                                                        .padding(.bottom, 13)
                                                }
                                            } else{
                                                if(gameGrid.0[row-1][column-1] == "e" || gameGrid.0[row-1][column-1] == "c"){
                                                    Ipad12ChosenTileEasy(win: $win, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if(gameGrid.0[row-1][column-1] == "b" || gameGrid.0[row-1][column-1] == "B"){
                                                    Ipad12BombTileEasy(health: $health, level: $level, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if (gameGrid.0[row-1][column-1] == "o" || (gameGrid.0[row-1][column-1] == "x")){
                                                    Ipad12StartEndTileEasy()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }.padding(.bottom, 80)
                            .padding(.leading, -10)
                    } else if difficulty == "Medium"{
                        VStack(spacing: 3){
                            ForEach(0..<9){row in
                                if row == 0{
                                    HStack(spacing: 3){
                                        ForEach(0..<9){column in
                                            if column == 0{
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 90)
                                            } else{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 90, height: 90)
                                                    Text(String(gameGrid.2[column-1]))
                                                        .font(.custom("Inter-Bold", size: 40))
                                                    
                                                        .padding(.bottom, 13)
                                                }
                                            }
                                        }
                                    }.padding(.bottom, -30)
                                } else{
                                    HStack(spacing: 3){
                                        ForEach(0..<9){column in
                                            if column == 0{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 90, height: 90)
                                                    Text(String(gameGrid.1[row-1]))
                                                        .font(.custom("Inter-Bold", size: 40))
                                                    
                                                        .padding(.bottom, 13)
                                                }
                                            } else{
                                                if(gameGrid.0[row-1][column-1] == "e" || gameGrid.0[row-1][column-1] == "c"){
                                                    Ipad12ChosenTileMedium(win: $win, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if(gameGrid.0[row-1][column-1] == "b" || gameGrid.0[row-1][column-1] == "B"){
                                                    Ipad12BombTileMedium(health: $health, level: $level, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if (gameGrid.0[row-1][column-1] == "o" || (gameGrid.0[row-1][column-1] == "x")){
                                                    Ipad12StartEndTileMedium()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }.padding(.bottom, 55)
                            .padding(.leading, -10)
                    } else if difficulty == "Hard"{
                        VStack(spacing: 3){
                            ForEach(0..<11){row in
                                if row == 0{
                                    HStack(spacing: 3){
                                        ForEach(0..<11){column in
                                            if column == 0{
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 70)
                                            } else{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 70, height: 70)
                                                    Text(String(gameGrid.2[column-1]))
                                                        .font(.custom("Inter-Bold", size: 30))
                                                    
                                                        .padding(.bottom, 13)
                                                }
                                            }
                                        }
                                    }.padding(.bottom, -50)
                                } else{
                                    HStack(spacing: 3){
                                        ForEach(0..<11){column in
                                            if column == 0{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 70, height: 70)
                                                    Text(String(gameGrid.1[row-1]))
                                                        .font(.custom("Inter-Bold", size: 30))
                                                    
                                                        .padding(.bottom, 13)
                                                }
                                            } else{
                                                if(gameGrid.0[row-1][column-1] == "e" || gameGrid.0[row-1][column-1] == "c"){
                                                    Ipad12ChosenTileHard(win: $win, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if(gameGrid.0[row-1][column-1] == "b" || gameGrid.0[row-1][column-1] == "B"){
                                                    Ipad12BombTileHard(health: $health, level: $level, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if (gameGrid.0[row-1][column-1] == "o" || (gameGrid.0[row-1][column-1] == "x")){
                                                    Ipad12StartEndTileHard()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }.padding(.bottom, 60)
                            .padding(.leading, -10)
                    }
                    
                }
                HStack{
                    ZStack{
                        Image("Time")
                            .resizable()
                            .frame(width: 235, height: 110)
                        HStack{
                            Image("Clock")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("09:53")
                                .font(.custom("Inter-Medium", size: 33))
                            
                        }
                        Image("Astronaut-Iphone")
                            .resizable()
                            .frame(width: 110, height: 110)
                            .offset(x: 5, y: -90)
                    }.padding(.trailing, 350)
                    Button{
                        if sound == true {
                            SoundEffectAudioManager.shared.playClickSound()
                        }
                        self.showHowToPlay.toggle()
                    } label:{
                        Image("HowToPlayButton")
                            .resizable()
                            .frame(width: 120, height: 110)
                    }
                }.padding(.top, 50)
            }
            if self.showPause{
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                PauseViewIpad12(language: $language, difficulty: $difficulty, showPause: $showPause, win: $win, gameGrid: $gameGrid, health: $health, level: $level, startTimer: startTimer, resetTimer: resetTimer, updateUserPlayer: updateUserPlayer)
                    .environmentObject(GameDataStore())
                    .onAppear{
                        stopTimer()
                    }
            }
            if self.win{
                Color.black.opacity(0.6).edgesIgnoringSafeArea(.all)
                WinViewIpad12(language: $language, difficulty: $difficulty, level: $level, health: $health, win: $win, gameGrid: $gameGrid, elapsedTime: $elapsedTime, resetTimer: resetTimer, updateUserPlayer: updateUserPlayer, updateTimeBadge: updateTimeBadge)
                    .environmentObject(GameDataStore())
                    .onAppear{
                        stopTimer()
                    }
            }
            if health == 0{
                Color.black.opacity(0.6).edgesIgnoringSafeArea(.all)
                LoseViewIpad12(language: $language, difficulty: $difficulty, level: $level, health: $health, win: $win, gameGrid: $gameGrid, resetTimer: resetTimer, updateUserPlayer: updateUserPlayer)
                    .environmentObject(GameDataStore())
                    .onAppear{
                        stopTimer()
                    }
            }
            if self.showHowToPlay{
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                HowToPlayViewIpad12(showHowToPlay: $showHowToPlay, language: $language)
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
