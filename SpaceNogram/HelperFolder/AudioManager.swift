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

import AVFoundation

class BackgroundAudioManager {
    // Class to store the audio player of the main menu's music and the gameView's music
    static let shared = BackgroundAudioManager()
    
    var mainMenuMusic: AVAudioPlayer?
    var gameViewMusic: AVAudioPlayer?
    
    func playMainMenuMusic() {
        guard let url = Bundle.main.url(forResource: "Background", withExtension: "mp3") else {
            print("Audio file not found.")
            return
        }
        
        do {
            mainMenuMusic = try AVAudioPlayer(contentsOf: url)
            mainMenuMusic?.numberOfLoops = -1 // Loop indefinitely
            mainMenuMusic?.volume = 0.25 // Decrease the volumn
            mainMenuMusic?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }
    
    func playGameViewMusic() {
        guard let url = Bundle.main.url(forResource: "GameView", withExtension: "mp3") else {
            return
        }
        
        do {
            gameViewMusic = try AVAudioPlayer(contentsOf: url)
            gameViewMusic?.numberOfLoops = -1 // Loop indefinitely
            gameViewMusic?.volume = 0.25 // Decrease the volumn
            gameViewMusic?.play()
        } catch {
            print("Error playing other music: \(error.localizedDescription)")
        }
    }
    
    func stopMainMenuMusic() {
        mainMenuMusic?.stop()
    }
    
    func stopGameViewMusic() {
        gameViewMusic?.stop()
    }
    
}

class SoundEffectAudioManager {
    // Class to store the audio player of all sound effects
    static let shared = SoundEffectAudioManager()
    
    var clickSound: AVAudioPlayer?
    var bombExplosionSound: AVAudioPlayer?
    var correctStepSound: AVAudioPlayer?
    var levelCompletedSound: AVAudioPlayer?
    var levelFailedSound: AVAudioPlayer?
    var winningStarsSound: AVAudioPlayer?
    
    func playClickSound() {
        guard let url = Bundle.main.url(forResource: "Click", withExtension: "mp3") else {
            print("Audio file not found.")
            return
        }
        
        do {
            clickSound = try AVAudioPlayer(contentsOf: url)
            clickSound?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }
    
    func playBombExplosionSound() {
        guard let url = Bundle.main.url(forResource: "BombExplosion", withExtension: "mp3") else {
            print("Audio file not found.")
            return
        }
        
        do {
            bombExplosionSound = try AVAudioPlayer(contentsOf: url)
            bombExplosionSound?.volume = 0.6
            bombExplosionSound?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }
    
    func playCorrectStepSound() {
        guard let url = Bundle.main.url(forResource: "CorrectStep", withExtension: "mp3") else {
            print("Audio file not found.")
            return
        }
        
        do {
            correctStepSound = try AVAudioPlayer(contentsOf: url)
            correctStepSound?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }
    
    func playLevelCompletedSound() {
        guard let url = Bundle.main.url(forResource: "LevelCompleted", withExtension: "mp3") else {
            print("Audio file not found.")
            return
        }
        
        do {
            levelCompletedSound = try AVAudioPlayer(contentsOf: url)
            levelCompletedSound?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }
    
    func playLevelFailedSound() {
        guard let url = Bundle.main.url(forResource: "LevelFailed", withExtension: "mp3") else {
            print("Audio file not found.")
            return
        }
        
        do {
            levelFailedSound = try AVAudioPlayer(contentsOf: url)
            levelFailedSound?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }
    
    func playWinningStarsSound() {
        guard let url = Bundle.main.url(forResource: "WinningStars", withExtension: "mp3") else {
            print("Audio file not found.")
            return
        }
        
        do {
            winningStarsSound = try AVAudioPlayer(contentsOf: url)
            winningStarsSound?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }
}
