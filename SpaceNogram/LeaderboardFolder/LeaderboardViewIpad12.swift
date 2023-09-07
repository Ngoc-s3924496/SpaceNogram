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

struct LeaderBoardViewIpad12 : View {
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
                    .frame(width: 800, height: 1050)
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
                                .frame(width: 70, height: 70)
                        }.padding(.top, 175)
                            .padding(.trailing, 155)
                    }
                    List{
                        // Loop through the data file and sorted the player based on the star they have in descending order
                        ForEach(gameData.players.sorted(by: { $0.stars > $1.stars })){player in
                            ZStack{
                                HStack{
                                    // Player avatar
                                    Image(player.avatar)
                                        .resizable()
                                        .frame(width: 110, height: 110)
                                        .padding(.trailing, 30)
                                    // Player basic stats
                                    VStack(alignment: .leading){
                                        Text(player.name)
                                            .font(.custom("Poppins-Bold", size: 32))
                                            .padding(.bottom, -13)
                                        Text(language == "English" ? player.titleE : player.titleVN)
                                        
                                            .font(.custom("Poppins-Medium", size: 26))
                                            .padding(.bottom, 3)
                                        HStack{
                                            Text(String(player.stars))
                                                .foregroundColor(Color("TitleColor"))
                                                .font(.custom("Poppins-Bold", size: 30))
                                            Image("Star")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .padding(.top, -5)
                                        }.padding(.top, -5)
                                    }.padding(.trailing, 150)
                                    Spacer()
                                    // Player star achivement image
                                    Image(player.achivementImage)
                                        .resizable()
                                        .frame(width: 110, height: 110)
                                        .padding(.leading, -260)
                                }.padding(.leading, 160)
                                    .padding(.bottom, -2)
                            }.listRowBackground(Color.clear)
                        }
                    }.listStyle(PlainListStyle())
                        .mask(
                            Rectangle()
                                .frame(width: 850, height: 870)
                                .padding(.bottom, 200)
                        )
                        .padding(.top, 25)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
