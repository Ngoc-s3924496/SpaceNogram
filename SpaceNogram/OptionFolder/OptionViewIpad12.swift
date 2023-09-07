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

struct OptionViewIpad12 : View {
    // Initilize variable
    @Binding var showOption: Bool
    @Binding var language: String
    @Binding var difficulty: String
    @Binding var music: Bool
    @Binding var sound: Bool
    @Binding var health: Int
    @Binding var level: Int
    @State private var refreshView = false
    @AppStorage("themeSetting") private var isDarkMode:Bool = true
    var body: some View{
        GeometryReader{ geometry in
            
            ZStack {
                // Background image
                Image((language == "English") ? "Option-Background-Ipad" : "Option-Background-Viet-Ipad")
                    .resizable()
                    .frame(width: 800, height: 1050)
                    .cornerRadius(20)
                VStack{
                    HStack{
                        Spacer()
                        // Close image
                        Button{
                            if sound == true {
                                SoundEffectAudioManager.shared.playClickSound()
                            }
                            showOption = false
                        } label: {
                            Image("CloseButton")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }.padding(.trailing, 155)
                            .padding(.top, -40)
                            .padding(.bottom, 45)
                    }
                    VStack(alignment: .leading){
                        // English language render
                        if (language == "English"){
                            Text("Difficulty")
                                .font(.custom("Inter-ExtraBold", size: 36))
                            
                                .padding(.leading, 5)
                            // Button to change the difficulty
                            Button{
                                if sound == true {
                                    SoundEffectAudioManager.shared.playClickSound()
                                }
                                if difficulty != "Easy"{
                                    level = 1
                                    health = 10
                                }
                                difficulty = "Easy"
                            } label: {
                                Image((difficulty == "Easy") ? "EasyChosen-Ipad" : "Easy-Ipad")
                                    .resizable()
                                    .frame(width: 680, height: 110)
                            }.padding(.top, -2)
                            Button{
                                if sound == true {
                                    SoundEffectAudioManager.shared.playClickSound()
                                }
                                if difficulty != "Medium"{
                                    level = 1
                                    health = 10
                                }
                                difficulty = "Medium"
                            } label: {
                                Image((difficulty == "Medium") ? "MediumChosen-Ipad" : "Medium-Ipad")
                                    .resizable()
                                    .frame(width: 680, height: 110)
                            }.padding(.top, -2)
                            Button{
                                if sound == true {
                                    SoundEffectAudioManager.shared.playClickSound()
                                }
                                if difficulty != "Hard"{
                                    level = 1
                                    health = 10
                                }
                                difficulty = "Hard"
                            } label: {
                                Image((difficulty == "Hard") ? "HardChosen-Ipad" : "Hard-Ipad")
                                    .resizable()
                                    .frame(width: 680, height: 110)
                            }.padding(.top, -2)
                            // Buttons to change language
                            HStack{
                                Text("Language")
                                    .font(.custom("Inter-ExtraBold", size: 36))
                                
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    language = "English"
                                } label: {
                                    Image("EnglishChosen-Ipad")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }.padding(.leading, 40)
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    language = "Vietnamese"
                                } label: {
                                    Image("Vietnamese-Ipad")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .padding(.leading, 10)
                                }
                            }
                            // Button to toggle background music on or off
                            HStack{
                                Text("Music")
                                    .font(.custom("Inter-ExtraBold", size: 36))
                                
                                ZStack{
                                    Image("Button-Ipad")
                                        .resizable()
                                        .frame(width: 122, height: 52)
                                    Button{
                                        if sound == true {
                                            SoundEffectAudioManager.shared.playClickSound()
                                        }
                                        music.toggle()
                                        if music == false{
                                            BackgroundAudioManager.shared.stopMainMenuMusic()
                                        } else{
                                            BackgroundAudioManager.shared.playMainMenuMusic()
                                        }
                                    } label: {
                                        Image((music == true) ? "GreenButton-Ipad" : "RedButton-Ipad")
                                            .resizable()
                                            .frame(width: 80, height:60)
                                            .padding(.top, 5)
                                            .offset(x: music == true ? -25 : 23)
                                    }
                                }.padding(.leading, 110)
                            }
                            // Button to toggle sound effect on or off
                            HStack{
                                Text("Sound")
                                    .font(.custom("Inter-ExtraBold", size: 36))
                                
                                ZStack{
                                    Image("Button-Ipad")
                                        .resizable()
                                        .frame(width: 122, height: 52)
                                    Button{
                                        sound.toggle()
                                        if sound == true {
                                            SoundEffectAudioManager.shared.playClickSound()
                                        }
                                    } label: {
                                        Image((sound == true) ? "GreenButton-Ipad" : "RedButton-Ipad")
                                            .resizable()
                                            .frame(width: 80, height: 60)
                                            .padding(.top, 3)
                                            .offset(x: sound == true ? -25 : 23)
                                    }
                                }.padding(.leading, 105)
                            }
                            // Button to toggle the color theme
                            HStack{
                                Text("Theme")
                                    .font(.custom("Inter-ExtraBold", size: 36))
                                
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    isDarkMode = true
                                    refreshView.toggle()
                                } label: {
                                    Image((isDarkMode == true) ? "DarkModeChosen-Ipad" : "DarkMode-Ipad")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }.padding(.leading, 90)
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    isDarkMode = false
                                    refreshView.toggle()
                                } label: {
                                    Image((isDarkMode != true) ? "LightModeChosen-Ipad" : "LightMode-Ipad")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }.padding(.leading, 13)
                            }
                        } else {
                            // Vietnamese render
                            Text("Chế Độ")
                                .font(.custom("Inter-ExtraBold", size: 36))
                            
                                .padding(.leading, 5)
                            //Buttons to change difficulty
                            Button{
                                if sound == true {
                                    SoundEffectAudioManager.shared.playClickSound()
                                }
                                if difficulty != "Easy"{
                                    level = 1
                                    health = 10
                                }
                                difficulty = "Easy"
                            } label: {
                                Image((difficulty == "Easy") ? "DeChosen-Ipad" : "De-Ipad")
                                    .resizable()
                                    .frame(width: 680, height: 110)
                            }.padding(.top, -2)
                            Button{
                                if sound == true {
                                    SoundEffectAudioManager.shared.playClickSound()
                                }
                                if difficulty != "Medium"{
                                    level = 1
                                    health = 10
                                }
                                difficulty = "Medium"
                            } label: {
                                Image((difficulty == "Medium") ? "TrungBinhChosen-Ipad" : "TrungBinh-Ipad")
                                    .resizable()
                                    .frame(width: 680, height: 110)
                            }.padding(.top, -2)
                            Button{
                                if sound == true {
                                    SoundEffectAudioManager.shared.playClickSound()
                                }
                                if difficulty != "Hard"{
                                    level = 1
                                    health = 10
                                }
                                difficulty = "Hard"
                            } label: {
                                Image((difficulty == "Hard") ? "KhoChosen-Ipad" : "Kho-Ipad")
                                    .resizable()
                                    .frame(width: 680, height: 110)
                            }.padding(.top, -2)
                            // Button to change language
                            HStack{
                                Text("Ngôn Ngữ")
                                    .font(.custom("Inter-ExtraBold", size: 36))
                                
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    language = "English"
                                } label: {
                                    Image("English-Ipad")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }.padding(.leading, 40)
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    language = "Vietnamese"
                                } label: {
                                    Image("VietnameseChosen-Ipad")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .padding(.leading, 10)
                                }
                            }
                            // Button to toggle background music on or off
                            HStack{
                                Text("Âm Nhạc")
                                    .font(.custom("Inter-ExtraBold", size: 36))
                                
                                ZStack{
                                    Image("Button-Ipad")
                                        .resizable()
                                        .frame(width: 122, height: 52)
                                    Button{
                                        if sound == true {
                                            SoundEffectAudioManager.shared.playClickSound()
                                        }
                                        music.toggle()
                                        if music == false{
                                            BackgroundAudioManager.shared.stopMainMenuMusic()
                                        } else{
                                            BackgroundAudioManager.shared.playMainMenuMusic()
                                        }
                                    } label: {
                                        Image((music == true) ? "GreenButton-Ipad" : "RedButton-Ipad")
                                            .resizable()
                                            .frame(width: 80, height:60)
                                            .padding(.top, 5)
                                            .offset(x: music == true ? -25 : 23)
                                    }
                                }.padding(.leading, 58)
                            }
                            // Button to toggle sound effect on or off
                            HStack{
                                Text("Âm Thanh")
                                    .font(.custom("Inter-ExtraBold", size: 36))
                                
                                ZStack{
                                    Image("Button-Ipad")
                                        .resizable()
                                        .frame(width: 122, height: 52)
                                    Button{
                                        sound.toggle()
                                        if sound == true {
                                            SoundEffectAudioManager.shared.playClickSound()
                                        }
                                    } label: {
                                        Image((sound == true) ? "GreenButton-Ipad" : "RedButton-Ipad")
                                            .resizable()
                                            .frame(width: 80, height: 60)
                                            .padding(.top, 3)
                                            .offset(x: sound == true ? -25 : 23)
                                    }
                                }.padding(.leading, 37)
                            }
                            // Button to toggle color theme
                            HStack{
                                Text("Màu Sắc")
                                    .font(.custom("Inter-ExtraBold", size: 36))
                                
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    isDarkMode = true
                                    refreshView.toggle()
                                } label: {
                                    Image((isDarkMode == true) ? "DarkModeChosen-Ipad" : "DarkMode-Ipad")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }.padding(.leading, 62)
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    isDarkMode = false
                                    refreshView.toggle()
                                } label: {
                                    Image((isDarkMode != true) ? "LightModeChosen-Ipad" : "LightMode-Ipad")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }.padding(.leading, 13)
                            }
                        }
                    }.padding(.leading, 20)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
