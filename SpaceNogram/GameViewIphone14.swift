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

// Comment for this view is applicable to its other variance which include GameViewIphone14ProMax, GameViewIpad11, GameViewIpad12
import SwiftUI

struct GameViewIphone14: View{
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
                            .frame(width: 75, height: 75)
                            .padding(.trailing, 45)
                    }
                    ZStack{
                        Image("BlueButton")
                            .resizable()
                            .frame(width: 105, height: 60)
                        HStack{
                            Image("Bomb")
                                .resizable()
                                .frame(width: 26, height: 26)
                            Text(difficulty == "Easy" ? "8" : (difficulty == "Medium" ? "12" : "20"))
                                .font(.custom("Inter-Bold", size: 22))
                            
                        }.padding(.top, -5)
                    }
                    ZStack{
                        Image("BlueButton")
                            .resizable()
                            .frame(width: 105, height: 60)
                        HStack{
                            Image("Heart")
                                .resizable()
                                .frame(width: 26, height: 26)
                            Text(String(health))
                                .font(.custom("Inter-Bold", size: 22))
                            
                        }.padding(.top, -5)
                    }
                }.padding(.bottom, 20)
                Text(language == "English" ? "Level \(String(level))" : "Vòng \(String(level))")
                    .font(.custom("Inter-ExtraBold", size: 25))
                
                    .padding(.bottom, 20)
                ZStack{
                    Image("TileBackground")
                        .resizable()
                        .frame(width: 355, height: 380)
                        .cornerRadius(15)
                    // Easy difficulty game
                    if difficulty == "Easy"{
                        VStack(spacing: 1){
                            // Initilize the grid
                            ForEach(0..<7){ row in
                                if row == 0{
                                    HStack(spacing: 3){
                                        ForEach(0..<7){column in
                                            // Blank space at the start
                                            if column == 0{
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 45)
                                            } else{
                                                // Horizontal alarm
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 45, height: 45)
                                                    Text(String(gameGrid.2[column-1]))
                                                        .font(.custom("Inter-Bold", size: 20))
                                                    
                                                        .padding(.bottom, 10)
                                                }
                                            }
                                        }
                                    }.padding(.bottom, -20)
                                } else{
                                    HStack(spacing: 3){
                                        ForEach(0..<7){column in
                                            if column == 0{
                                                // Vertical alarm
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 45, height: 45)
                                                    Text(String(gameGrid.1[row-1]))
                                                        .font(.custom("Inter-Bold", size: 20))
                                                    
                                                        .padding(.bottom, 10)
                                                }
                                            } else{
                                                // Create tile based on the gamegrid array value
                                                if(gameGrid.0[row-1][column-1] == "e" || gameGrid.0[row-1][column-1] == "c"){
                                                    Iphone14ChosenTileEasy(win: $win, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if(gameGrid.0[row-1][column-1] == "b" || gameGrid.0[row-1][column-1] == "B"){
                                                    Iphone14BombTileEasy(health: $health, level: $level, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if (gameGrid.0[row-1][column-1] == "o" || (gameGrid.0[row-1][column-1] == "x")){
                                                    Iphone14StartEndTileEasy()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }.padding(.bottom, 24)
                            .padding(.leading, -10)
                        // Medium difficulty game, similar logic to the above
                    } else if difficulty == "Medium"{
                        VStack(spacing: 1){
                            ForEach(0..<9){row in
                                if row == 0{
                                    HStack(spacing: 3){
                                        ForEach(0..<9){column in
                                            if column == 0{
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 35)
                                            } else{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 35, height: 35)
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
                                                        .frame(width: 35, height: 35)
                                                    Text(String(gameGrid.1[row-1]))
                                                        .font(.custom("Inter-Bold", size: 16))
                                                    
                                                        .padding(.bottom, 7)
                                                }
                                            } else{
                                                if(gameGrid.0[row-1][column-1] == "e" || gameGrid.0[row-1][column-1] == "c"){
                                                    Iphone14ChosenTileMedium(win: $win, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if(gameGrid.0[row-1][column-1] == "b" || gameGrid.0[row-1][column-1] == "B"){
                                                    Iphone14BombTileMedium(health: $health, level: $level, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if (gameGrid.0[row-1][column-1] == "o" || (gameGrid.0[row-1][column-1] == "x")){
                                                    Iphone14StartEndTileMedium()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }.padding(.bottom, 24)
                            .padding(.leading, -10)
                        // Hard difficulty game, similar logic to medium and easy game
                    } else if difficulty == "Hard"{
                        VStack(spacing: 1){
                            ForEach(0..<11){row in
                                if row == 0{
                                    HStack(spacing: 2){
                                        ForEach(0..<11){column in
                                            if column == 0{
                                                Rectangle()
                                                    .foregroundColor(.clear)
                                                    .frame(width: 28)
                                            } else{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 28, height: 28)
                                                    Text(String(gameGrid.2[column-1]))
                                                        .font(.custom("Inter-Bold", size: 12))
                                                    
                                                        .padding(.bottom, 5)
                                                }
                                            }
                                        }
                                    }.padding(.bottom, -28)
                                } else{
                                    HStack(spacing: 2){
                                        ForEach(0..<11){column in
                                            if column == 0{
                                                ZStack{
                                                    Image("Alarm")
                                                        .resizable()
                                                        .frame(width: 28, height: 28)
                                                    Text(String(gameGrid.1[row-1]))
                                                        .font(.custom("Inter-Bold", size: 12))
                                                    
                                                        .padding(.bottom, 5)
                                                }
                                            } else{
                                                if(gameGrid.0[row-1][column-1] == "e" || gameGrid.0[row-1][column-1] == "c"){
                                                    Iphone14ChosenTileHard(win: $win, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if(gameGrid.0[row-1][column-1] == "b" || gameGrid.0[row-1][column-1] == "B"){
                                                    Iphone14BombTileHard(health: $health, level: $level, gameGrid: $gameGrid, row: row-1, column: column-1)
                                                } else if (gameGrid.0[row-1][column-1] == "o" || (gameGrid.0[row-1][column-1] == "x")){
                                                    Iphone14StartEndTileHard()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }.padding(.bottom, 20)
                            .padding(.leading, -10)
                    }
                    
                }
                HStack{
                    ZStack{
                        Image("Time")
                            .resizable()
                            .frame(width: 125, height: 55)
                        HStack{
                            Image("Clock")
                                .resizable()
                                .frame(width: 22, height: 25)
                            Text(formatTime(elapsedTime))
                                .font(.custom("Inter-Medium", size: 18))
                            
                        }
                        Image("Astronaut-Iphone")
                            .resizable()
                            .frame(width: 74, height: 74)
                            .offset(x: 5, y: -54)
                    }.padding(.trailing, 130)
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
                            .frame(width: 55, height: 55)
                    }
                }.padding(.top, 130)
            }
            if self.showPause{
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                PauseViewIphone14(language: $language, difficulty: $difficulty, showPause: $showPause, win: $win, gameGrid: $gameGrid, health: $health, level: $level, startTimer: startTimer, resetTimer: resetTimer, updateUserPlayer: updateUserPlayer)
                    .environmentObject(GameDataStore())
                    .onAppear{
                        stopTimer()
                    }
            }
            if self.win{
                Color.black.opacity(0.6).edgesIgnoringSafeArea(.all)
                WinViewIphone14(language: $language, difficulty: $difficulty, level: $level, health: $health, win: $win, gameGrid: $gameGrid, elapsedTime: $elapsedTime, resetTimer: resetTimer, updateUserPlayer: updateUserPlayer, updateTimeBadge: updateTimeBadge)
                    .environmentObject(GameDataStore())
                    .onAppear{
                        stopTimer()
                    }
            }
            if health == 0{
                Color.black.opacity(0.6).edgesIgnoringSafeArea(.all)
                LoseViewIphone14(language: $language, difficulty: $difficulty, level: $level, health: $health, win: $win, gameGrid: $gameGrid, resetTimer: resetTimer, updateUserPlayer: updateUserPlayer)
                    .environmentObject(GameDataStore())
                    .onAppear{
                        stopTimer()
                    }
            }
            if self.showHowToPlay{
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                HowToPlayViewIphone14(showHowToPlay: $showHowToPlay, language: $language)
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
    // Change time interval to suitable format
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
