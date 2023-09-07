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

struct LeaderBoardViewIpad11 : View {
    // Initilize variable
    @EnvironmentObject var gameData: GameDataStore
    @Binding var showLeaderBoard: Bool
    @Binding var language: String
    @AppStorage("soundSetting") private var sound: Bool = true
    var body: some View{
        GeometryReader{ geometry in
            
            ZStack {
                // Background image
                Image((language == "English") ? "Leaderboard-Background" : "Leaderboard-Background-Viet")
                    .resizable()
                    .frame(width: 650, height: 900)
                    .cornerRadius(20)
                
                VStack{
                    HStack{
                        Spacer()
                        // Close button
                        Button{
                            if sound == true {
                                SoundEffectAudioManager.shared.playClickSound()
                            }
                            showLeaderBoard = false
                        } label: {
                            Image("CloseButton")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }.padding(.top, 166)
                            .padding(.trailing, 135)
                    }
                    List{
                        // Loop through the data file and sorted the player based on the star they have in descending order
                        ForEach(gameData.players.sorted(by: { $0.stars > $1.stars })){player in
                            ZStack{
                                HStack{
                                    // Player avatar
                                    Image(player.avatar)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .padding(.trailing, 20)
                                    // Player basic stats
                                    VStack(alignment: .leading){
                                        Text(player.name)
                                            .font(.custom("Poppins-Bold", size: 28))
                                            .padding(.bottom, -15)
                                        Text(language == "English" ? player.titleE : player.titleVN)
                                        
                                            .font(.custom("Poppins-Medium", size: 22))
                                            .padding(.bottom, 1)
                                        HStack{
                                            Text(String(player.stars))
                                                .foregroundColor(Color("TitleColor"))
                                                .font(.custom("Poppins-Bold", size: 26))
                                            Image("Star")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .padding(.top, -5)
                                        }.padding(.top, -5)
                                    }.padding(.trailing, 80)
                                    Spacer()
                                    // Player star achivement image
                                    Image(player.achivementImage)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .padding(.leading, -220)
                                }.padding(.leading, 140)
                                    .padding(.bottom, -7)
                            }.listRowBackground(Color.clear)
                        }
                    }.listStyle(PlainListStyle())
                        .mask(
                            Rectangle()
                                .frame(width: 800, height: 760)
                                .padding(.bottom, 200)
                        )
                        .padding(.top, 15)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
