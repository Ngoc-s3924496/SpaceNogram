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

struct HowToPlayViewIphone14: View{
    @Binding var showHowToPlay: Bool
    @Binding var language: String
    @State var step: Int = 1
    @AppStorage("soundSetting") private var sound: Bool = true
    var body: some View{
        GeometryReader{ geometry in
            
            ZStack {
                Image(language == "English" ? "HowToPlayBackground-Iphone" : "CachChoiBackground-Iphone")
                    .resizable()
                    .frame(width: 340, height: 420)
                VStack{
                    Button{
                        if sound == true {
                            SoundEffectAudioManager.shared.playClickSound()
                        }
                        showHowToPlay.toggle()
                    } label: {
                        Image("CloseButton")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .padding(.leading, 270)
                            .padding(.top, -22)
                            .padding(.bottom, 30)
                    }
                    Image("Step\(step)")
                        .resizable()
                        .frame(width: 210, height: 140)
                    ZStack{
                        Rectangle()
                            .fill(Color("HowToPlayRectangle"))
                            .frame(width: 210, height: 115)
                        Text(language == "English" ? getStepInstructionE(step: step) : getStepInstructionVN(step: step))
                            .font(.custom("Inter-Bold", size: 15))
                            .multilineTextAlignment(.center)
                            .frame(width: 180)
                    }
                    .padding(.top, -8)
                    HStack{
                        // Decrease the step to get to the next instruction
                        Button{
                            if sound == true {
                                SoundEffectAudioManager.shared.playClickSound()
                            }
                            if step > 1{
                                step -= 1
                            }
                        } label: {
                            Image("Arrow2")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .rotationEffect(Angle(degrees: 180))
                        }
                        ForEach(1..<7){ i in
                            Circle()
                                .fill(i == step ? Color("DotsChosenColor") : Color("DotsColor"))
                                .frame(width: 15)
                        }
                        // Increase the step to get to the next instruction
                        Button{
                            if sound == true {
                                SoundEffectAudioManager.shared.playClickSound()
                            }
                            if step < 6{
                                step += 1
                            }
                        } label: {
                            Image("Arrow2")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
