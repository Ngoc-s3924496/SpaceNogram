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

struct HowToPlayViewIpad12: View{
    @Binding var showHowToPlay: Bool
    @Binding var language: String
    @State var step: Int = 1
    @AppStorage("soundSetting") private var sound: Bool = true
    var body: some View{
        GeometryReader{ geometry in
            
            ZStack {
                Image(language == "English" ? "HowToPlayBackground-Iphone" : "CachChoiBackground-Iphone")
                    .resizable()
                    .frame(width: 800, height: 1000)
                VStack{
                    Button{
                        if sound == true {
                            SoundEffectAudioManager.shared.playClickSound()
                        }
                        showHowToPlay.toggle()
                    } label: {
                        Image("CloseButton")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding(.leading, 600)
                            .padding(.top, -40)
                            .padding(.bottom, 65)
                    }
                    Image("Step\(step)")
                        .resizable()
                        .frame(width: 550, height: 340)
                    ZStack{
                        Rectangle()
                            .fill(Color("HowToPlayRectangle"))
                            .frame(width: 550, height: 270)
                        Text(language == "English" ? getStepInstructionE(step: step) : getStepInstructionVN(step: step))
                            .font(.custom("Inter-Bold", size: 36))
                            .multilineTextAlignment(.center)
                            .frame(width: 500)
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
                                .frame(width: 95, height: 95)
                                .rotationEffect(Angle(degrees: 180))
                        }
                        ForEach(1..<7){ i in
                            Circle()
                                .fill(i == step ? Color("DotsChosenColor") : Color("DotsColor"))
                                .frame(width: 32)
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
                                .frame(width: 95, height: 95)
                        }
                    }
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
