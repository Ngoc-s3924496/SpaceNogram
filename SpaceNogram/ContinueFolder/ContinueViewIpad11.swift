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

struct ContinueViewIpad11: View {
    // Initilize variable
    @Binding var language: String
    @Binding var difficulty: String
    @Binding var health: Int
    @Binding var level: Int
    @Binding var showContinue: Bool
    @AppStorage("soundSetting") private var sound: Bool = true
    var body: some View{
        GeometryReader{ geometry in
            
            ZStack {
                Image("ContinueBackground")
                    .resizable()
                    .frame(width: 700, height: 450)
                VStack(alignment: .center){
                    Text(language == "English" ? "You have an ongoing game. Do you want to continue?" : "Bạn có một trò chơi đang diễn ra. Bạn có muốn tiếp tục không?")
                        .font(.custom("Inter-ExtraBold", size: 36))
                    
                        .frame(width: 600)
                        .multilineTextAlignment(.center)
                    HStack{
                        // Take the user to the gameView with the saved data if press yes
                        NavigationLink{
                            GameViewIpad11(difficulty: $difficulty, language: $language).navigationBarBackButtonHidden(true)
                                .environmentObject(GameDataStore())
                        } label: {
                            Image(language == "English" ? "Yes" : "Co")
                                .resizable()
                                .frame(width: 195, height: 90)
                        }
                        // Remove the saved data if press no
                        Button{
                            if sound == true {
                                SoundEffectAudioManager.shared.playClickSound()
                            }
                            level = 1
                            health = 10
                            showContinue.toggle()
                        } label: {
                            Image(language == "English" ? "No" : "Khong")
                                .resizable()
                                .frame(width: 195, height: 90)
                        }
                    }
                    .padding(.top, 10)
                }
                
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
