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

struct MainMenuView: View {
    // Initilize the variable
    @EnvironmentObject var gameData: GameDataStore
    @State private var astronautOffset: CGFloat = 0
    @State private var moveAstronautUp = false
    @State private var showLeaderBoard: Bool = false
    @State private var showOption: Bool = false
    @State private var showProfile: Bool = false
    @State private var showContinue: Bool = false
    @State private var showHowToPlay: Bool = false
    @AppStorage("languageSetting") private var language: String = "English"
    @AppStorage("difficultySetting") private var difficulty: String = "Easy"
    @AppStorage("musicSetting") private var music: Bool = true
    @AppStorage("soundSetting") private var sound: Bool = true
    @AppStorage("themeSetting") private var isDarkMode:Bool = true
    @AppStorage("health") private var health: Int = 10
    @AppStorage("level") private var level: Int = 1
    var body: some View {
        GeometryReader { geometry in
            NavigationView{
                ZStack{
                    // Render for Ipad Pro 12.9 inch
                    if geometry.size.width > 1000 {
                        MainMenuViewIpad12(astronautOffset: $astronautOffset, sound: $sound, level: $level, language: $language, music: $music, difficulty: $difficulty, health: $health, animateAstronaut: animateAstronautIpad12)
                    }
                    // Render for Ipad Pro 11 inch
                    else if geometry.size.width > 800 {
                        MainMenuViewIpad11(astronautOffset: $astronautOffset, sound: $sound, level: $level, language: $language, music: $music, difficulty: $difficulty, health: $health, animateAstronaut: animateAstronaut)
                    }
                    // Render for Iphone 14 Pro Max
                    else if geometry.size.width > 400{
                        MainMenuViewIphone14ProMax(astronautOffset: $astronautOffset, sound: $sound, level: $level, language: $language, music: $music, difficulty: $difficulty, health: $health, animateAstronaut: animateAstronaut)
                    }
                    // Render for Iphone 14 and Iphone 14 Pro
                    else{
                        MainMenuViewIphone14(astronautOffset: $astronautOffset, sound: $sound, level: $level, language: $language, music: $music, difficulty: $difficulty, health: $health, animateAstronaut: animateAstronaut)
                    }
                }.navigationBarHidden(true)
                    .onAppear{
                        // Stop gameView music and play main menu music if music variable is set to true
                        if music == true{
                            BackgroundAudioManager.shared.stopGameViewMusic()
                            BackgroundAudioManager.shared.playMainMenuMusic()
                        }
                    }
            }.navigationViewStyle(StackNavigationViewStyle())
                .environment(\.colorScheme, isDarkMode ? .dark : .light)
        }.statusBarHidden(true)
            .edgesIgnoringSafeArea(.all)
    }
    func animateAstronaut() {
        // Move astronaut Image Up and Down
        withAnimation(Animation.easeInOut(duration: 2).repeatForever()) {
            if moveAstronautUp {
                astronautOffset = -100
            } else {
                astronautOffset = 100
            }
            moveAstronautUp.toggle()
        }
    }
    // Move astronaut Image Up and Down on Ipad Pro 12.9 inch screen size
    func animateAstronautIpad12() {
        withAnimation(Animation.easeInOut(duration: 2).repeatForever()) {
            if moveAstronautUp {
                astronautOffset = -300
            } else {
                astronautOffset = 300
            }
            moveAstronautUp.toggle()
        }
    }
}



struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        MainMenuView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
        MainMenuView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        MainMenuView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (4th generation)"))
            .previewDisplayName("iPad Pro 11 inch")
        MainMenuView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
            .previewDisplayName("iPad Pro 12.9 inch")
    }
}
