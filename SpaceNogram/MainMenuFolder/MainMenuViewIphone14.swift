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

struct MainMenuViewIphone14: View{
    // Initialize variable
    @State private var showLeaderBoard: Bool = false
    @State private var showOption: Bool = false
    @State private var showProfile: Bool = false
    @State private var showContinue: Bool = false
    @State private var showHowToPlay: Bool = false
    @Binding var astronautOffset: CGFloat
    @Binding var sound: Bool
    @Binding var level: Int
    @Binding var language: String
    @Binding var music: Bool
    @Binding var difficulty: String
    @Binding var health: Int
    @AppStorage("themeSetting") private var isDarkMode:Bool = true
    var animateAstronaut: () -> Void
    var body: some View{
        ZStack{
            Image("Background-Iphone-14")
                .resizable()
                .ignoresSafeArea()
            Image("Astronaut-Iphone")
                .resizable()
                .frame(width: 280, height: 280)
                .padding(.top, 100 - astronautOffset)
                .padding(.trailing, 25)
                .onAppear() {
                    animateAstronaut()
                }
            VStack{
                HStack{
                    Button{
                        self.showProfile.toggle()
                        if sound == true {
                            SoundEffectAudioManager.shared.playClickSound()
                        }
                    } label: {
                        Image("Account-Iphone")
                            .resizable()
                            .frame(width: 65, height: 65)
                            .padding(.leading, 25)
                    }
                    
                    Spacer()
                    Button{
                        self.showOption.toggle()
                        if sound == true {
                            SoundEffectAudioManager.shared.playClickSound()
                        }
                    } label: {
                        Image("Setting-Iphone")
                            .resizable()
                            .frame(width: 65, height: 65)
                            .padding(.trailing, 30)
                    }
                    
                }.padding(.top, 5)
                Image("Title-Iphone")
                    .resizable()
                    .frame(width: 400, height: 135)
                Spacer()
                // If level is 1 then there is no current ongoing game, so set the link to start a new game
                if level == 1 {
                    NavigationLink{
                        GameViewIphone14(difficulty: $difficulty, language: $language).navigationBarBackButtonHidden(true)
                            .environmentObject(GameDataStore())
                    } label: {
                        Image((language == "English") ? "StartNow-Iphone" : "BatDau-Iphone")
                            .resizable()
                            .frame(width: 250, height: 59)
                            .padding(.bottom, -7)
                    }.onAppear{
                        self.showContinue = false
                    }
                }
                else{
                    // If level is not 1 then there is an ongoing game, so set the button to the continue button
                    Button{
                        self.showContinue.toggle()
                        if sound == true {
                            SoundEffectAudioManager.shared.playClickSound()
                        }
                    } label: {
                        Image((language == "English") ? "Continue-Iphone" : "TiepTuc-Iphone")
                            .resizable()
                            .frame(width: 250, height: 59)
                            .padding(.bottom, -7)
                    }
                }
                Button{
                    self.showHowToPlay.toggle()
                    if sound == true {
                        SoundEffectAudioManager.shared.playClickSound()
                    }
                } label: {
                    Image((language == "English") ? "HowToPlay-Iphone" : "CachChoi-Iphone")
                        .resizable()
                        .frame(width: 250, height: 59)
                        .padding(.bottom, -7)
                }
                Button{
                    self.showLeaderBoard.toggle()
                    if sound == true {
                        SoundEffectAudioManager.shared.playClickSound()
                    }
                } label: {
                    Image((language == "English") ? "Leaderboard-Iphone" : "BangXepHang-Iphone")
                        .resizable()
                        .frame(width: 250, height: 59)
                        .padding(.bottom, -10)
                }
            }
            if self.showLeaderBoard {
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                LeaderBoardViewIphone14(showLeaderBoard: $showLeaderBoard, language: $language)
                    .environmentObject(GameDataStore())
            }
            if self.showOption {
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                OptionViewIphone14(showOption: $showOption, language: $language, difficulty: $difficulty, music: $music, sound: $sound,  health: $health, level: $level)
            }
            if self.showProfile {
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                ProfileViewIphone14(showProfile: $showProfile, language: $language)
                    .environmentObject(GameDataStore())
            }
            if self.showContinue {
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                ContinueViewIphone14(language: $language, difficulty: $difficulty, health: $health, level: $level, showContinue: $showContinue)
            }
            if self.showHowToPlay{
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                HowToPlayViewIphone14(showHowToPlay: $showHowToPlay, language: $language)
            }
        }.environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}
