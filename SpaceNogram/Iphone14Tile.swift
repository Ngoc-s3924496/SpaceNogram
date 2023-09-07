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

// Comment for this view is applicable to its other variance which include GameViewIphone14ProMax, GameViewIpad11, GameViewIpad12
// Comment for the chosenTileEasy is also applicable to chosenTileMedium and chosenTileHard
// Comment for the bombTileEasy is also applicable to bombTileMedium and bombTileHard


import SwiftUI

struct Iphone14ChosenTileEasy: View{
    @Binding var win: Bool
    @Binding var gameGrid: ([[Character]], [Int], [Int], [Int], [Int])
    @AppStorage("soundSetting") private var sound: Bool = true
    var row: Int
    var column: Int
    var body: some View{
        // Normal tile have 'e' value before chosen and "c" after been chosen
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
                    .frame(width: 45, height: 45)
            }
        }
    }
}

struct Iphone14ChosenTileMedium: View{
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
                    .frame(width: 35, height: 35)
            }
        }
    }
}

struct Iphone14ChosenTileHard: View{
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
                    .frame(width: 28, height: 28)
            }
        }
    }
}

struct Iphone14BombTileEasy: View{
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
        // Bomb tile have "b" value before chosen and "B" after chosen
        Button{
            // Create the probability for if the chosen bomb is a super bomb, superbomb appear in level 10 and appear more often later on
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
                // super bomb deal twice damage as a normal bomb
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
                    .frame(width: 45, height: 45)
                if showBomb {
                    Image(superBomb == false ? "Bomb" : "SuperBomb")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .padding(.top, -25)
                        .padding(.leading, 5)
                }
                if showExplosion {
                    Image("Explosion")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .scaleEffect(showExplosion ? 2 : 1.0)
                        .animation(.easeOut(duration: 0.5), value: showExplosion)
                        .padding(.top, -25)
                        .padding(.leading, 5)
                }
            }.onChange(of: showBomb){ newValue in
                // Animation by changing the state with a delay
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

struct Iphone14BombTileMedium: View{
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
                    .frame(width: 35, height: 35)
                if showBomb {
                    Image(superBomb == false ? "Bomb" : "SuperBomb")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.top, -5)
                        .padding(.leading, 5)
                }
                if showExplosion {
                    Image("Explosion")
                        .resizable()
                        .frame(width: 30, height: 30)
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

struct Iphone14BombTileHard: View{
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
                    .frame(width: 28, height: 28)
                if showBomb {
                    Image(superBomb == false ? "Bomb" : "SuperBomb")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .padding(.top, -13)
                        .padding(.leading, 5)
                }
                if showExplosion {
                    Image("Explosion")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .scaleEffect(showExplosion ? 2 : 1.0)
                        .animation(.easeOut(duration: 0.5), value: showExplosion)
                        .padding(.top, -13)
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

struct Iphone14StartEndTileEasy: View{
    var body: some View{
        ZStack{
            Image("Tile")
                .resizable()
                .frame(width: 45, height: 45)
            Image("Flag")
                .resizable()
                .frame(width: 35, height: 35)
                .padding(.top, -25)
                .padding(.leading, 10)
        }
    }
}

struct Iphone14StartEndTileMedium: View{
    var body: some View{
        ZStack{
            Image("Tile")
                .resizable()
                .frame(width: 35, height: 35)
            Image("Flag")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.top, -15)
                .padding(.leading, 5)
        }
    }
}

struct Iphone14StartEndTileHard: View{
    var body: some View{
        ZStack{
            Image("Tile")
                .resizable()
                .frame(width: 28, height: 28)
            Image("Flag")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.top, -13)
                .padding(.leading, 5)
        }
    }
}

