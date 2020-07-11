//
//  SoundManager.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/12/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var audioPlayer:AVAudioPlayer?
    
    enum SoundEffect {
        
        case happyBirthdayCheers
        case trash

    }
    
    static func playSound(_ effect:SoundEffect) {
        
        var soundFilename = ""
        
        switch effect {
            
        case .happyBirthdayCheers:
            soundFilename = "happyBirthdayCheers"
            
        case .trash:
            soundFilename = "trash"

        }
        
        let filePath = Bundle.main.path(forResource: soundFilename, ofType: "mp3")
        
        guard filePath != nil else {
            print("Couldn't find sound file \(soundFilename) in the bundle")
            return
        }
        
        let soundUrl = URL(fileURLWithPath: filePath!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            audioPlayer?.play()
        }
        catch {
            print("Couldn't create the audio player object for sound file \(soundFilename)")
        }
    }
    
}

