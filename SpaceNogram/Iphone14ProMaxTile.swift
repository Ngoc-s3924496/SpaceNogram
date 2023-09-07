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

struct Iphone14ProMaxChosenTileEasy: View{
    @Binding var win: Bool
    @Binding var gameGrid: ([[Character]], [Int], [Int], [Int], [Int])
    @AppStorage("soundSetting") private var sound: Bool = true
    var row: Int
    var column: Int
    var body: some View{
        Button{
            if gameGrid.0[row][column] != "c"{
                if sound == true {
                    SoundEffectAudioManager.shared.playCorrectStepSound()
                }
                gameGrid.0[row][column] = "c"
                win = hasValidPathFromStartToEnd(&gameGrid.0, startRow: gameGrid.3[0], startCol: gameGrid.3[1], endRow: gameGrid.4[0], endCol: gameGrid.4[1])
            }
        } label: {
            ZStack{
                Image(gameGrid.0[row][column] != "c" ? "Tile" : "ChosenTile")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
        }
    }
}

struct Iphone14ProMaxChosenTileMedium: View{
    @Binding var win: Bool
    @Binding var gameGrid: ([[Character]], [Int], [Int], [Int], [Int])
    @AppStorage("soundSetting") private var sound: Bool = true
    var row: Int
    var column: Int
    var body: some View{
        Button{
            if gameGrid.0[row][column] != "c"{
                if sound == true {
                    SoundEffectAudioManager.shared.playCorrectStepSound()
                }
                gameGrid.0[row][column] = "c"
                win = hasValidPathFromStartToEnd(&gameGrid.0, startRow: gameGrid.3[0], startCol: gameGrid.3[1], endRow: gameGrid.4[0], endCol: gameGrid.4[1])
            }
        } label: {
            ZStack{
                Image(gameGrid.0[row][column] != "c" ? "Tile" : "ChosenTile")
                    .resizable()
                    .frame(width: 38, height: 38)
            }
        }
    }
}

struct Iphone14ProMaxChosenTileHard: View{
    @Binding var win: Bool
    @Binding var gameGrid: ([[Character]], [Int], [Int], [Int], [Int])
    @AppStorage("soundSetting") private var sound: Bool = true
    var row: Int
    var column: Int
    var body: some View{
        Button{
            if gameGrid.0[row][column] != "c"{
                if sound == true {
                    SoundEffectAudioManager.shared.playCorrectStepSound()
                }
                gameGrid.0[row][column] = "c"
                win = hasValidPathFromStartToEnd(&gameGrid.0, startRow: gameGrid.3[0], startCol: gameGrid.3[1], endRow: gameGrid.4[0], endCol: gameGrid.4[1])
            }
        } label: {
            ZStack{
                Image(gameGrid.0[row][column] != "c" ? "Tile" : "ChosenTile")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
        }
    }
}

struct Iphone14ProMaxBombTileEasy: View{
    @State private var showBomb: Bool = false
    @State private var showExplosion: Bool = false
    @State private var superBomb: Bool = false
    @Binding var health: Int
    @Binding var level: Int
    @Binding var gameGrid: ([[Character]], [Int], [Int], [Int], [Int])
    @AppStorage("soundSetting") private var sound: Bool = true
    var row: Int
    var column: Int
    var body: some View{
        Button{
            if level >= 10 {
                var probability = 0.1 + ((Double(level - 10)) * 0.05)
                if probability > 0.5{
                    probability = 0.5
                }
                let randomValue = Double.random(in: 0.0..<1.0)
                superBomb = randomValue < probability
            }
            if gameGrid.0[row][column] != "B"{
                if sound == true {
                    SoundEffectAudioManager.shared.playBombExplosionSound()
                }
                self.showBomb = true
                if health > 0{
                    if superBomb{
                        health -= 2
                        if health < 0 {
                            health = 0
                        }
                    } else{
                        health -= 1
                    }
                }
            }
        } label: {
            ZStack{
                Image(gameGrid.0[row][column] != "B" ? "Tile" : "RedTile")
                    .resizable()
                    .frame(width: 50, height: 50)
                if showBomb {
                    Image(superBomb == false ? "Bomb" : "SuperBomb")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.top, -25)
                        .padding(.leading, 5)
                }
                if showExplosion {
                    Image("Explosion")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .scaleEffect(showExplosion ? 2 : 1.0)
                        .animation(.easeOut(duration: 0.5), value: showExplosion)
                        .padding(.top, -25)
                        .padding(.leading, 5)
                }
            }.onChange(of: showBomb){ newValue in
                if newValue{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        withAnimation{
                            showExplosion = true
                            gameGrid.0[row][column] = "B"
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        withAnimation{
                            showExplosion = false
                            showBomb = false
                        }
                    }
                }
            }
        }
    }
}

struct Iphone14ProMaxBombTileMedium: View{
    @State private var showBomb: Bool = false
    @State private var showExplosion: Bool = false
    @State private var superBomb: Bool = false
    @Binding var health: Int
    @Binding var level: Int
    @Binding var gameGrid: ([[Character]], [Int], [Int], [Int], [Int])
    @AppStorage("soundSetting") private var sound: Bool = true
    var row: Int
    var column: Int
    var body: some View{
        Button{
            if level >= 10 {
                var probability = 0.1 + ((Double(level - 10)) * 0.05)
                if probability > 0.5{
                    probability = 0.5
                }
                let randomValue = Double.random(in: 0.0..<1.0)
                superBomb = randomValue < probability
            }
            if gameGrid.0[row][column] != "B"{
                if sound == true {
                    SoundEffectAudioManager.shared.playBombExplosionSound()
                }
                self.showBomb = true
                if health > 0{
                    if superBomb{
                        health -= 2
                        if health < 0 {
                            health = 0
                        }
                    } else{
                        health -= 1
                    }
                }
            }
        } label: {
            ZStack{
                Image(gameGrid.0[row][column] != "B" ? "Tile" : "RedTile")
                    .resizable()
                    .frame(width: 38, height: 38)
                if showBomb {
                    Image(superBomb == false ? "Bomb" : "SuperBomb")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .padding(.top, -20)
                        .padding(.leading, 5)
                }
                if showExplosion {
                    Image("Explosion")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .scaleEffect(showExplosion ? 2 : 1.0)
                        .animation(.easeOut(duration: 0.5), value: showExplosion)
                        .padding(.top, -15)
                        .padding(.leading, 5)
                }
            }.onChange(of: showBomb){ newValue in
                if newValue{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        withAnimation{
                            showExplosion = true
                            gameGrid.0[row][column] = "B"
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        withAnimation{
                            showExplosion = false
                            showBomb = false
                        }
                    }
                }
            }
        }
    }
}

struct Iphone14ProMaxBombTileHard: View{
    @State private var showBomb: Bool = false
    @State private var showExplosion: Bool = false
    @State private var superBomb: Bool = false
    @Binding var health: Int
    @Binding var level: Int
    @Binding var gameGrid: ([[Character]], [Int], [Int], [Int], [Int])
    @AppStorage("soundSetting") private var sound: Bool = true
    var row: Int
    var column: Int
    var body: some View{
        Button{
            if level >= 10 {
                var probability = 0.1 + ((Double(level - 10)) * 0.05)
                if probability > 0.5{
                    probability = 0.5
                }
                let randomValue = Double.random(in: 0.0..<1.0)
                superBomb = randomValue < probability
            }
            if gameGrid.0[row][column] != "B"{
                if sound == true {
                    SoundEffectAudioManager.shared.playBombExplosionSound()
                }
                self.showBomb = true
                if health > 0{
                    if superBomb{
                        health -= 2
                        if health < 0 {
                            health = 0
                        }
                    } else{
                        health -= 1
                    }
                }
            }
        } label: {
            ZStack{
                Image(gameGrid.0[row][column] != "B" ? "Tile" : "RedTile")
                    .resizable()
                    .frame(width: 32, height: 32)
                if showBomb {
                    Image(superBomb == false ? "Bomb" : "SuperBomb")
                        .resizable()
                        .frame(width: 27, height: 27)
                        .padding(.top, -20)
                        .padding(.leading, 5)
                }
                if showExplosion {
                    Image("Explosion")
                        .resizable()
                        .frame(width: 27, height: 27)
                        .scaleEffect(showExplosion ? 2 : 1.0)
                        .animation(.easeOut(duration: 0.5), value: showExplosion)
                        .padding(.top, -20)
                        .padding(.leading, 5)
                }
            }.onChange(of: showBomb){ newValue in
                if newValue{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        withAnimation{
                            showExplosion = true
                            gameGrid.0[row][column] = "B"
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        withAnimation{
                            showExplosion = false
                            showBomb = false
                        }
                    }
                }
            }
        }
    }
}

struct Iphone14ProMaxStartEndTileEasy: View{
    var body: some View{
        ZStack{
            Image("Tile")
                .resizable()
                .frame(width: 50, height: 50)
            Image("Flag")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.top, -25)
                .padding(.leading, 10)
        }
    }
}

struct Iphone14ProMaxStartEndTileMedium: View{
    var body: some View{
        ZStack{
            Image("Tile")
                .resizable()
                .frame(width: 38, height: 38)
            Image("Flag")
                .resizable()
                .frame(width: 32, height: 32)
                .padding(.top, -15)
                .padding(.leading, 5)
        }
    }
}

struct Iphone14ProMaxStartEndTileHard: View{
    var body: some View{
        ZStack{
            Image("Tile")
                .resizable()
                .frame(width: 32, height: 32)
            Image("Flag")
                .resizable()
                .frame(width: 27, height: 27)
                .padding(.top, -13)
                .padding(.leading, 5)
        }
    }
}

