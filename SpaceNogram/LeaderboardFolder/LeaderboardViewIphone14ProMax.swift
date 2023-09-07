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

struct LeaderBoardViewIphone14ProMax : View {
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
                    .frame(width: 390, height: 580)
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
                                .frame(width: 40, height: 40)
                        }.padding(.top, 143)
                            .padding(.trailing, 45)
                    }
                    List{
                        // Loop through the data file and sorted the player based on the star they have in descending order
                        ForEach(gameData.players.sorted(by: { $0.stars > $1.stars })){player in
                            ZStack{
                                HStack{
                                    // Player avatar
                                    Image(player.avatar)
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .padding(.trailing, 10)
                                    // Player basic stats
                                    VStack(alignment: .leading){
                                        Text(player.name)
                                            .font(.custom("Poppins-Bold", size: 16))
                                            .padding(.bottom, -10)
                                        Text(language == "English" ? player.titleE : player.titleVN)
                                        
                                            .font(.custom("Poppins-Medium", size: 14))
                                            .padding(.bottom, 0)
                                        HStack{
                                            Text(String(player.stars))
                                                .foregroundColor(Color("TitleColor"))
                                                .font(.custom("Poppins-Bold", size: 15))
                                            Image("Star")
                                                .resizable()
                                                .frame(width: 18, height: 18)
                                                .padding(.top, -5)
                                        }.padding(.top, -10)
                                    }.padding(.trailing, 40)
                                    Spacer()
                                    // Player star achivement image
                                    Image(player.achivementImage)
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .padding(.leading, -90)
                                }.padding(.leading, 40)
                                    .padding(.bottom, -7)
                            }.listRowBackground(Color.clear)
                        }
                    }.listStyle(PlainListStyle())
                        .mask(
                            Rectangle()
                                .frame(width: 400, height: 520)
                                .padding(.bottom, 200)
                        )
                        .padding(.top, 10)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
