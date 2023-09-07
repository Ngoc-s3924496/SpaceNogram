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

struct ProfileViewIphone14ProMax : View {
    // Initilize variable
    @EnvironmentObject var gameData: GameDataStore
    @Binding var showProfile: Bool
    @Binding var language: String
    @State var editProfile: Bool = false
    @AppStorage("soundSetting") private var sound: Bool = true
    var body: some View{
        GeometryReader{ geometry in
            ZStack{
                // Statistic and achivement part
                if editProfile == false{
                    Image((language == "English") ? "Profile-Background-Iphone" : "TieuSu-Background-Iphone")
                        .resizable()
                        .frame(width: 390, height: 630)
                        .cornerRadius(20)
                    VStack{
                        HStack{
                            Spacer()
                            Button{
                                if sound == true {
                                    SoundEffectAudioManager.shared.playClickSound()
                                }
                                showProfile = false
                            } label: {
                                Image("CloseButton")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }.padding(.trailing, 40)
                                .padding(.top, -35)
                                .padding(.bottom, 5)
                        }
                        ZStack{
                            Image(gameData.userPlayer!.avatar)
                                .resizable()
                                .frame(width: 130, height: 130)
                                .cornerRadius(45)
                            Button{
                                if sound == true {
                                    SoundEffectAudioManager.shared.playClickSound()
                                }
                                editProfile.toggle()
                            } label: {
                                Image("Edit")
                                    .resizable()
                                    .frame(width: 55, height: 55)
                                    .padding(.top, 110)
                                    .padding(.leading, 115)
                            }
                        }
                        .padding(.bottom, 5)
                        Text(gameData.userPlayer!.name)
                            .font(.custom("Inter-ExtraBold", size: 22))
                        
                            .padding(.bottom, 0)
                        Text(language == "English" ? gameData.userPlayer!.titleE : gameData.userPlayer!.titleVN)
                            .font(.custom("Inter-Bold", size: 18))
                            .foregroundColor(Color("TitleColor"))
                        HStack{
                            ZStack{
                                Image("StarsBox")
                                    .resizable()
                                    .frame(width: 137, height: 66)
                                HStack{
                                    Text(String(gameData.userPlayer!.stars))
                                        .font(.custom("Inter-ExtraBold", size: 32))
                                        .foregroundColor(.yellow)
                                    Image("Star")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .offset(x: -1, y: -2)
                                }
                            }
                            Image(gameData.userPlayer!.achivementImage)
                                .resizable()
                                .frame(width: 65, height: 65)
                        }
                        // Statistic part
                        ZStack {
                            Image("RecordTable")
                                .resizable()
                                .frame(width: 320, height: 220)
                            ScrollView {
                                VStack(alignment: .leading, spacing: 5){
                                    if language == "English"{
                                        Text("Records:")
                                            .font(.custom("Inter-Bold", size: 19))
                                        
                                        HStack{
                                            Text("Total Game Play: ")
                                                .font(.custom("Inter-Medium", size: 17))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.totalGame))
                                                .font(.custom("Inter-Bold", size: 17))
                                            
                                                .padding(.trailing, 70)
                                        }
                                        HStack{
                                            Text("Highest Streak Easy: ")
                                                .font(.custom("Inter-Medium", size: 17))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.highestStreakEasy))
                                                .font(.custom("Inter-Bold", size: 17))
                                            
                                                .padding(.trailing, 70)
                                        }
                                        HStack{
                                            Text("Highest Streak Medium: ")
                                                .font(.custom("Inter-Medium", size: 17))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.highestStreakMedium))
                                                .font(.custom("Inter-Bold", size: 17))
                                            
                                                .padding(.trailing, 70)
                                        }
                                        HStack{
                                            Text("Highest Streak Hard: ")
                                                .font(.custom("Inter-Medium", size: 17))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.highestStreakHard))
                                                .font(.custom("Inter-Bold", size: 17))
                                            
                                                .padding(.trailing, 70)
                                        }
                                        // Achivements part
                                        Text("Achivements:")
                                            .font(.custom("Inter-Bold", size: 19))
                                        Group{
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Bronze")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    Text("Have less than 20 stars")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, -5)
                                                        .frame(width: 150)
                                                }
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Silver")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    Text("Have 20-39 stars")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 10)
                                                }
                                                // Non unlock badge will be black out
                                                Color.black.opacity(gameData.userPlayer!.starBadge2 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Gold")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    Text("Have 40-60 stars")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 10)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.starBadge3 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("SuperGold")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    Text("Have more than 60 stars")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .frame(width: 150)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.starBadge4 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Badge1")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    Text("Played 20 games")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 10)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.playedBadge1 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Badge2")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    Text("Played 50 games")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 10)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.playedBadge2 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Badge3")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                        .padding(.leading, 10)
                                                    Text("Played 100 games")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 10)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.playedBadge3 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Badge4")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    Text("Finished a game in 90 seconds")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 10)
                                                        .frame(width: 150)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.timeBadge1 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Badge5")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    Text("Finished a game in 30 seconds")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 10)
                                                        .frame(width: 150)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.timeBadge2 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Badge6")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    Text("Finished a game in 10 seconds")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 10)
                                                        .frame(width: 150)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.timeBadge3 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                        }
                                    } else{
                                        Text("Kỷ Lục:")
                                            .font(.custom("Inter-Bold", size: 19))
                                        
                                        HStack{
                                            Text("Tổng Số Vòng Chơi: ")
                                                .font(.custom("Inter-Medium", size: 17))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.totalGame))
                                                .font(.custom("Inter-Bold", size: 17))
                                            
                                                .padding(.trailing, 70)
                                        }
                                        HStack{
                                            Text("Chuỗi Thắng Dễ: ")
                                                .font(.custom("Inter-Medium", size: 17))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.highestStreakEasy))
                                                .font(.custom("Inter-Bold", size: 17))
                                            
                                                .padding(.trailing, 70)
                                        }
                                        HStack{
                                            Text("Chuỗi Thắng Trung Bình: ")
                                                .font(.custom("Inter-Medium", size: 17))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.highestStreakMedium))
                                                .font(.custom("Inter-Bold", size: 17))
                                            
                                                .padding(.trailing, 70)
                                        }
                                        HStack{
                                            Text("Chuỗi Thắng Khó: ")
                                                .font(.custom("Inter-Medium", size: 17))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.highestStreakHard))
                                                .font(.custom("Inter-Bold", size: 17))
                                            
                                                .padding(.trailing, 70)
                                        }
                                        Text("Huy Chương:")
                                            .font(.custom("Inter-Bold", size: 18))
                                        
                                        Group{
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Bronze")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    Text("Có ít hơn 20 sao")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, -5)
                                                        .frame(width: 150)
                                                }
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Silver")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                        .padding(.leading, -25)
                                                    Text("Có 20-39 sao")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 20)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.starBadge2 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Gold")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                        .padding(.leading, -25)
                                                    Text("Có 40-60 sao")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 20)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.starBadge3 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("SuperGold")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    Text("Có nhiều hơn 60 sao")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .frame(width: 150)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.starBadge4 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Badge1")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                        .padding(.leading, -30)
                                                    Text("Chơi 20 vòng")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 15)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.playedBadge1 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Badge2")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                        .padding(.leading, -30)
                                                    Text("Chơi 50 vòng")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 15)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.playedBadge2 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Badge3")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                        .padding(.leading, -25)
                                                    Text("Chơi 100 vòng")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 15)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.playedBadge3 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Badge4")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    Text("Hoàn thành màn trong 90 giây")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 10)
                                                        .frame(width: 150)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.timeBadge1 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Badge5")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    Text("Hoàn thành màn trong 30 giây")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 10)
                                                        .frame(width: 150)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.timeBadge2 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 280, height: 70)
                                                HStack{
                                                    Image("Badge6")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    Text("Hoàn thành màn trong 10 giây")
                                                        .font(.custom("Inter-SemiBold", size: 17))
                                                        .padding(.leading, 10)
                                                        .frame(width: 150)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.timeBadge3 == false ? 0.3 : 0)
                                                    .frame(width: 270, height: 65)
                                            }.offset(x: -4)
                                        }
                                    }
                                }
                                
                            }.padding(.top, 10)
                                .padding(.leading, 75)
                                .padding(.bottom, 10)
                        }
                        .frame(height: 200)
                        .padding(.bottom, -10)
                        
                    }
                    
                }
                // Edit profile part
                else{
                    Image((language == "English") ? "EditProfile-Background-Iphone" : "ChinhSua-Background-Iphone")
                        .resizable()
                        .frame(width: 350, height: 380)
                        .cornerRadius(20)
                    VStack{
                        HStack{
                            // Button to change the previous avatar in the avatar list
                            Button{
                                if sound == true {
                                    SoundEffectAudioManager.shared.playClickSound()
                                }
                                gameData.decrementAvatarNumber()
                                gameData.saveDataToFile()
                            } label: {
                                Image("Arrow1")
                                    .resizable()
                                    .frame(width: 20, height: 29)
                                    .rotationEffect(.degrees(180))
                                Image(gameData.userPlayer!.avatar)
                                    .resizable()
                                    .frame(width: 123, height: 123)
                                    .cornerRadius(40)
                                // Button to change the latter avatar in the avatar list
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    gameData.incrementAvatarNumber()
                                    gameData.saveDataToFile()
                                } label: {
                                    Image("Arrow1")
                                        .resizable()
                                        .frame(width: 20, height: 29)
                                }
                            }
                        }
                        ZStack{
                            Rectangle()
                                .fill(.white)
                                .cornerRadius(5)
                                .frame(width: 180, height: 35)
                            // Text field to change the username, the name is limit to a max of 15 characters
                            TextField("Username", text: Binding(
                                get: { gameData.userPlayer?.name ?? "" },
                                set: { newName in
                                    gameData.userPlayer?.name = newName
                                    if newName.count > 15 {
                                        gameData.userPlayer?.name = String(newName.prefix(15))
                                    }
                                    gameData.saveDataToFile()
                                }
                            ))
                            .font(.custom("Inter-Bold", size: 18))
                            .foregroundColor(.black)
                            .padding(.leading, 135)
                        }.padding(.top, 10)
                        Button{
                            if sound == true {
                                SoundEffectAudioManager.shared.playClickSound()
                            }
                            editProfile.toggle()
                        } label: {
                            Image((language == "English") ? "BackButton" : "QuayLai")
                                .resizable()
                                .frame(width: 157, height: 60)
                                .padding(.top, 15)
                                .padding(.bottom, -40)
                        }
                    }
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
                .onAppear{
                    updatePlayedBadge(gameData: gameData)
                }
        }
    }
}
