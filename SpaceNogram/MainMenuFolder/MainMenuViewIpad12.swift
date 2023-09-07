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

struct MainMenuViewIpad12: View{
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
            Image("Background-Ipad")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Image("Astronaut-Ipad")
                    .resizable()
                    .frame(width: 350, height: 350)
                    .padding(.top, 230 - astronautOffset)
                    .padding(.trailing, 45)
                    .onAppear(){
                        animateAstronaut()
                    }
            }
            VStack{
                HStack{
                    Button{
                        self.showProfile.toggle()
                        if sound == true {
                            SoundEffectAudioManager.shared.playClickSound()
                        }
                    } label: {
                        Image("Account-Ipad")
                            .resizable()
                            .frame(width: 110, height: 110)
                            .padding(.leading, 55)
                    }
                    
                    Spacer()
                    Button{
                        self.showOption.toggle()
                        if sound == true {
                            SoundEffectAudioManager.shared.playClickSound()
                        }
                    } label: {
                        Image("Setting-Ipad")
                            .resizable()
                            .frame(width: 110, height: 110)
                            .padding(.trailing, 60)
                    }
                    
                }.padding(.top, 50)
                Image("Title-Ipad")
                    .resizable()
                    .frame(width: 835, height: 235)
                Spacer()
                // If level is 1 then there is no current ongoing game, so set the link to start a new game
                if level == 1{
                    NavigationLink{
                        GameViewIpad12(difficulty: $difficulty, language: $language).navigationBarBackButtonHidden(true)
                            .environmentObject(GameDataStore())
                    } label: {
                        Image((language == "English") ? "StartNow-Ipad" : "BatDau-Ipad")
                            .resizable()
                            .frame(width: 400, height: 100)
                            .padding(.bottom, 3)
                    }.onAppear{
                        self.showContinue = false
                    }
                } else{
                    // If level is not 1 then there is an ongoing game, so set the button to the continue button
                    Button{
                        self.showContinue.toggle()
                        if sound == true {
                            SoundEffectAudioManager.shared.playClickSound()
                        }
                    } label: {
                        Image((language == "English") ? "Continue-Ipad" : "TiepTuc-Ipad")
                            .resizable()
                            .frame(width: 400, height: 100)
                            .padding(.bottom, 3)
                    }
                }
                Button{
                    self.showHowToPlay.toggle()
                    if sound == true {
                        SoundEffectAudioManager.shared.playClickSound()
                    }
                } label: {
                    Image((language == "English") ? "HowToPlay-Ipad" : "CachChoi-Ipad")
                        .resizable()
                        .frame(width: 400, height: 100)
                        .padding(.bottom, 3)
                }
                Button{
                    self.showLeaderBoard.toggle()
                    if sound == true {
                        SoundEffectAudioManager.shared.playClickSound()
                    }
                } label: {
                    Image((language == "English") ? "Leaderboard-Ipad" : "BangXepHang-Ipad")
                        .resizable()
                        .frame(width: 400, height: 100)
                        .padding(.bottom, 33)
                        .scaledToFit()
                }
                
            }
            if self.showLeaderBoard {
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                LeaderBoardViewIpad12(showLeaderBoard: $showLeaderBoard, language: $language)
                    .environmentObject(GameDataStore())
            }
            if self.showOption {
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                OptionViewIpad12(showOption: $showOption, language: $language, difficulty: $difficulty, music: $music, sound: $sound, health: $health, level: $level)
            }
            if self.showProfile {
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                ProfileViewIpad12(showProfile: $showProfile, language: $language)
                    .environmentObject(GameDataStore())
            }
            if self.showContinue {
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                ContinueViewIpad12(language: $language, difficulty: $difficulty, health: $health, level: $level, showContinue: $showContinue)
            }
            if self.showHowToPlay{
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                HowToPlayViewIpad12(showHowToPlay: $showHowToPlay, language: $language)
            }
        }.environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}
