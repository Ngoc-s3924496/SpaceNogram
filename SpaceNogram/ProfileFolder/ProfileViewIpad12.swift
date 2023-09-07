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

struct ProfileViewIpad12 : View {
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
                    Image((language == "English") ? "Profile-Background-Ipad" : "TieuSu-Background-Ipad")
                        .resizable()
                        .frame(width: 830, height: 1080)
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
                                    .frame(width: 80, height: 80)
                            }.padding(.trailing, 140)
                                .padding(.top, -180)
                        }
                        ZStack{
                            Image(gameData.userPlayer!.avatar)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .cornerRadius(50)
                            Button{
                                if sound == true {
                                    SoundEffectAudioManager.shared.playClickSound()
                                }
                                editProfile.toggle()
                            } label: {
                                Image("Edit")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .padding(.top, 160)
                                    .padding(.leading, 175)
                            }
                        }
                        .padding(.bottom, 5)
                        .padding(.top, -00)
                        Text(gameData.userPlayer!.name)
                            .font(.custom("Inter-ExtraBold", size: 36))
                        
                            .padding(.bottom, 0)
                        Text(language == "English" ? gameData.userPlayer!.titleE : gameData.userPlayer!.titleVN)
                            .font(.custom("Inter-Bold", size: 26))
                            .foregroundColor(Color("TitleColor"))
                        HStack{
                            ZStack{
                                Image("StarsBox")
                                    .resizable()
                                    .frame(width: 167, height: 86)
                                HStack{
                                    Text(String(gameData.userPlayer!.stars))
                                        .font(.custom("Inter-ExtraBold", size: 46))
                                        .foregroundColor(.yellow)
                                    Image("Star")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                        .offset(x: 1, y: -2)
                                }
                            }
                            Image(gameData.userPlayer!.achivementImage)
                                .resizable()
                                .frame(width: 85, height: 85)
                        }
                        // Statistic part
                        ZStack {
                            Image("RecordTable")
                                .resizable()
                                .frame(width: 750, height: 320)
                            ScrollView {
                                VStack(alignment: .leading, spacing: 12){
                                    if language == "English"{
                                        Text("Records:")
                                            .font(.custom("Inter-Bold", size: 28))
                                        
                                        HStack{
                                            Text("Total Game Play: ")
                                                .font(.custom("Inter-Medium", size: 26))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.totalGame))
                                                .font(.custom("Inter-Bold", size: 26))
                                            
                                                .padding(.trailing, 180)
                                        }
                                        HStack{
                                            Text("Highest Streak Easy: ")
                                                .font(.custom("Inter-Medium", size: 26))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.highestStreakEasy))
                                                .font(.custom("Inter-Bold", size: 26))
                                            
                                                .padding(.trailing, 180)
                                        }
                                        HStack{
                                            Text("Highest Streak Medium: ")
                                                .font(.custom("Inter-Medium", size: 26))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.highestStreakMedium))
                                                .font(.custom("Inter-Bold", size: 26))
                                            
                                                .padding(.trailing, 180)
                                        }
                                        HStack{
                                            Text("Highest Streak Hard: ")
                                                .font(.custom("Inter-Medium", size: 26))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.highestStreakHard))
                                                .font(.custom("Inter-Bold", size: 26))
                                            
                                                .padding(.trailing, 180)
                                        }
                                        // Achivements part
                                        Text("Achivements:")
                                            .font(.custom("Inter-Bold", size: 28))
                                        
                                        Group{
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Bronze")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                    Text("Have less than 20 stars")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 10)
                                                }
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Silver")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                        .padding(.leading, -60)
                                                    Text("Have 20-39 stars")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 10)
                                                }
                                                // Non unlock badge will be black out
                                                Color.black.opacity(gameData.userPlayer!.starBadge2 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Gold")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                        .padding(.leading, -55)
                                                    Text("Have 40-60 stars")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 10)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.starBadge3 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("SuperGold")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                        .padding(.leading, 55)
                                                    Text("Have more than 60 stars")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .frame(width: 350)
                                                        .padding(.leading, -3)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.starBadge4 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Badge1")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                        .padding(.leading, -50)
                                                    Text("Played 20 games")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 15)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.playedBadge1 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Badge2")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                        .padding(.leading, -50)
                                                    Text("Played 50 games")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 15)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.playedBadge2 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Badge3")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                        .padding(.leading, -35)
                                                    Text("Played 100 games")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 15)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.playedBadge3 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Badge4")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                    Text("Finished a game in 90 seconds")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 5)
                                                        .frame(width: 280)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.timeBadge1 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Badge5")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                    Text("Finished a game in 30 seconds")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 5)
                                                        .frame(width: 280)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.timeBadge2 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Badge6")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                    Text("Finished a game in 10 seconds")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 5)
                                                        .frame(width: 280)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.timeBadge3 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                        }
                                    } else{
                                        Text("Kỷ Lục:")
                                            .font(.custom("Inter-Bold", size: 28))
                                        
                                        HStack{
                                            Text("Tổng Số Vòng Chơi: ")
                                                .font(.custom("Inter-Medium", size: 26))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.totalGame))
                                                .font(.custom("Inter-Bold", size: 26))
                                            
                                                .padding(.trailing, 180)
                                        }
                                        HStack{
                                            Text("Chuỗi Thắng Dễ: ")
                                                .font(.custom("Inter-Medium", size: 26))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.highestStreakEasy))
                                                .font(.custom("Inter-Bold", size: 26))
                                            
                                                .padding(.trailing, 180)
                                        }
                                        HStack{
                                            Text("Chuỗi Thắng Trung Bình: ")
                                                .font(.custom("Inter-Medium", size: 26))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.highestStreakMedium))
                                                .font(.custom("Inter-Bold", size: 26))
                                            
                                                .padding(.trailing, 180)
                                        }
                                        HStack{
                                            Text("Chuỗi Thắng Khó: ")
                                                .font(.custom("Inter-Medium", size: 26))
                                            
                                            Spacer()
                                            Text(String(gameData.userPlayer!.highestStreakHard))
                                                .font(.custom("Inter-Bold", size: 26))
                                            
                                                .padding(.trailing, 180)
                                        }
                                        Text("Huy Chương:")
                                            .font(.custom("Inter-Bold", size: 28))
                                        
                                        Group{
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Bronze")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                        .padding(.leading, -30)
                                                    Text("Có ít hơn 20 sao")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 10)
                                                }
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Silver")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                        .padding(.leading, -60)
                                                    Text("Có 20-39 sao")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 10)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.starBadge2 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Gold")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                        .padding(.leading, -55)
                                                    Text("Có 40-60 sao")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 10)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.starBadge3 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("SuperGold")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                        .padding(.leading, 55)
                                                    Text("Có nhiều hơn 60 sao")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .frame(width: 300)
                                                        .padding(.leading, -3)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.starBadge4 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Badge1")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                        .padding(.leading, -50)
                                                    Text("Chơi 20 vòng")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 15)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.playedBadge1 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Badge2")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                        .padding(.leading, -50)
                                                    Text("Chơi 50 vòng")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 15)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.playedBadge2 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Badge3")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                        .padding(.leading, -35)
                                                    Text("Chơi 100 vòng")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 15)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.playedBadge3 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Badge4")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                    Text("Hoàn thành màn trong 90 giây")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 5)
                                                        .frame(width: 240)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.timeBadge1 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Badge5")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                    Text("Hoàn thành màn trong 30 giây")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 5)
                                                        .frame(width: 240)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.timeBadge2 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                            ZStack{
                                                Image("BadgeBox")
                                                    .resizable()
                                                    .frame(width: 520, height: 120)
                                                HStack{
                                                    Image("Badge6")
                                                        .resizable()
                                                        .frame(width: 75, height: 75)
                                                    Text("Hoàn thành màn trong 10 giây")
                                                        .font(.custom("Inter-SemiBold", size: 26))
                                                        .padding(.leading, 5)
                                                        .frame(width: 240)
                                                }
                                                Color.black.opacity(gameData.userPlayer!.timeBadge3 == false ? 0.3 : 0)
                                                    .frame(width: 510, height: 110)
                                            }.offset(x: 70)
                                        }
                                    }
                                }
                                
                            }.padding(.top, 20)
                                .padding(.leading, 190)
                                .padding(.bottom, 20)
                        }
                        .padding(.top, 115)
                        .frame(height: 200)
                        .padding(.bottom, -10)
                        
                    }
                    
                }
                // Edit profile part
                else{
                    Image((language == "English") ? "EditProfile-Background-Ipad" : "ChinhSua-Background-Ipad")
                        .resizable()
                        .frame(width: 800, height: 850)
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
                                    .frame(width: 50, height: 59)
                                    .rotationEffect(.degrees(180))
                                Image(gameData.userPlayer!.avatar)
                                    .resizable()
                                    .frame(width: 240, height: 240)
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
                                        .frame(width: 50, height: 59)
                                }
                            }
                        }
                        ZStack{
                            Rectangle()
                                .fill(.white)
                                .cornerRadius(5)
                                .frame(width: 360, height: 65)
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
                            .font(.custom("Inter-Bold", size: 33))
                            .foregroundColor(.black)
                            .padding(.leading, 355)
                        }.padding(.top, 20)
                        Button{
                            if sound == true {
                                SoundEffectAudioManager.shared.playClickSound()
                            }
                            editProfile.toggle()
                        } label: {
                            Image((language == "English") ? "BackButton" : "QuayLai")
                                .resizable()
                                .frame(width: 287, height: 120)
                                .padding(.top, 25)
                                .padding(.bottom, -80)
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
