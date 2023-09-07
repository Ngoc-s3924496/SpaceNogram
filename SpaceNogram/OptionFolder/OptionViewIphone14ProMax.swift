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

struct OptionViewIphone14ProMax : View {
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
                Image((language == "English") ? "Option-Background-Iphone" : "Option-Background-Viet-Iphone")
                    .resizable()
                    .frame(width: 390, height: 650)
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
                                .frame(width: 40, height: 40)
                        }.padding(.trailing, 45)
                            .padding(.top, -30)
                            .padding(.bottom, 25)
                    }
                    VStack(alignment: .leading){
                        // English language render
                        if (language == "English"){
                            Text("Difficulty")
                                .font(.custom("Inter-ExtraBold", size: 22))
                            
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
                                Image((difficulty == "Easy") ? "EasyChosen-Iphone" : "Easy-Iphone")
                                    .resizable()
                                    .frame(width: 320, height: 66)
                            }.padding(.top, -10)
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
                                Image((difficulty == "Medium") ? "MediumChosen-Iphone" : "Medium-Iphone")
                                    .resizable()
                                    .frame(width: 320, height: 66)
                            }.padding(.top, -10)
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
                                Image((difficulty == "Hard") ? "HardChosen-Iphone" : "Hard-Iphone")
                                    .resizable()
                                    .frame(width: 320, height: 66)
                            }.padding(.top, -10)
                            // Buttons to change language
                            HStack{
                                Text("Language")
                                    .font(.custom("Inter-ExtraBold", size: 22))
                                
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    language = "English"
                                } label: {
                                    Image("EnglishChosen-Iphone")
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                }.padding(.leading, 20)
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    language = "Vietnamese"
                                } label: {
                                    Image("Vietnamese-Iphone")
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                        .padding(.leading, 10)
                                }
                            }
                            // Button to toggle background music on or off
                            HStack{
                                Text("Music")
                                    .font(.custom("Inter-ExtraBold", size: 22))
                                
                                ZStack{
                                    Image("Button-Iphone")
                                        .resizable()
                                        .frame(width: 82, height: 32)
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
                                        Image((music == true) ? "GreenButton-Iphone" : "RedButton-Iphone")
                                            .resizable()
                                            .frame(width: 55, height: 42)
                                            .padding(.top, 3)
                                            .offset(x: music == true ? -19 : 18)
                                    }
                                }.padding(.leading, 65)
                            }
                            // Button to toggle sound effect on or off
                            HStack{
                                Text("Sound")
                                    .font(.custom("Inter-ExtraBold", size: 22))
                                
                                ZStack{
                                    Image("Button-Iphone")
                                        .resizable()
                                        .frame(width: 82, height: 32)
                                    Button{
                                        sound.toggle()
                                        if sound == true {
                                            SoundEffectAudioManager.shared.playClickSound()
                                        }
                                    } label: {
                                        Image((sound == true) ? "GreenButton-Iphone" : "RedButton-Iphone")
                                            .resizable()
                                            .frame(width: 55, height: 42)
                                            .padding(.top, 3)
                                            .offset(x: sound == true ? -19 : 18)
                                    }
                                }.padding(.leading, 60)
                            }
                            // Button to toggle the color theme
                            HStack{
                                Text("Theme")
                                    .font(.custom("Inter-ExtraBold", size: 22))
                                
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    isDarkMode = true
                                    refreshView.toggle()
                                } label: {
                                    Image((isDarkMode == true) ? "DarkModeChosen-Iphone" : "DarkMode-Iphone")
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                }.padding(.leading, 50)
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    isDarkMode = false
                                    refreshView.toggle()
                                } label: {
                                    Image((isDarkMode != true) ? "LightModeChosen-Iphone" : "LightMode-Iphone")
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                }.padding(.leading, 13)
                            }
                        } else {
                            // Vietnamese render
                            Text("Chế Độ")
                                .font(.custom("Inter-ExtraBold", size: 22))
                            
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
                                Image((difficulty == "Easy") ? "DeChosen-Iphone" : "De-Iphone")
                                    .resizable()
                                    .frame(width: 320, height: 66)
                            }.padding(.top, -10)
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
                                Image((difficulty == "Medium") ? "TrungBinhChosen-Iphone" : "TrungBinh-Iphone")
                                    .resizable()
                                    .frame(width: 320, height: 66)
                            }.padding(.top, -10)
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
                                Image((difficulty == "Hard") ? "KhoChosen-Iphone" : "Kho-Iphone")
                                    .resizable()
                                    .frame(width: 320, height: 66)
                            }.padding(.top, -10)
                            // Button to change language
                            HStack{
                                Text("Ngôn Ngữ")
                                    .font(.custom("Inter-ExtraBold", size: 22))
                                
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    language = "English"
                                } label: {
                                    Image("English-Iphone")
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                }.padding(.leading, 20)
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    language = "Vietnamese"
                                } label: {
                                    Image("VietnameseChosen-Iphone")
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                        .padding(.leading, 10)
                                }
                            }
                            // Button to toggle background music on or off
                            HStack{
                                Text("Âm Nhạc")
                                    .font(.custom("Inter-ExtraBold", size: 22))
                                
                                ZStack{
                                    Image("Button-Iphone")
                                        .resizable()
                                        .frame(width: 82, height: 32)
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
                                        Image((music == true) ? "GreenButton-Iphone" : "RedButton-Iphone")
                                            .resizable()
                                            .frame(width: 55, height: 42)
                                            .padding(.top, 3)
                                            .offset(x: music == true ? -19 : 18)
                                    }
                                }.padding(.leading, 33)
                            }
                            // Button to toggle sound effect on or off
                            HStack{
                                Text("Âm Thanh")
                                    .font(.custom("Inter-ExtraBold", size: 20))
                                
                                ZStack{
                                    Image("Button-Iphone")
                                        .resizable()
                                        .frame(width: 82, height: 32)
                                    Button{
                                        sound.toggle()
                                        if sound == true {
                                            SoundEffectAudioManager.shared.playClickSound()
                                        }
                                    } label: {
                                        Image((sound == true) ? "GreenButton-Iphone" : "RedButton-Iphone")
                                            .resizable()
                                            .frame(width: 55, height: 42)
                                            .padding(.top, 3)
                                            .offset(x: sound == true ? -19 : 18)
                                    }
                                }.padding(.leading, 29)
                            }
                            // Button to toggle color theme
                            HStack{
                                Text("Màu Sắc")
                                    .font(.custom("Inter-ExtraBold", size: 22))
                                
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    isDarkMode = true
                                    refreshView.toggle()
                                } label: {
                                    Image((isDarkMode == true) ? "DarkModeChosen-Iphone" : "DarkMode-Iphone")
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                }.padding(.leading, 33)
                                Button{
                                    if sound == true {
                                        SoundEffectAudioManager.shared.playClickSound()
                                    }
                                    isDarkMode = false
                                    refreshView.toggle()
                                } label: {
                                    Image((isDarkMode != true) ? "LightModeChosen-Iphone" : "LightMode-Iphone")
                                        .resizable()
                                        .frame(width: 65, height: 65)
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
