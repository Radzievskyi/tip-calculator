//
//  AudioPlayerService.swift
//  tip-calculator
//
//  Created by Mykhailo Radzievskyi on 2023-12-12.
//

import Foundation
import AVFoundation

protocol AudioPlayerService {
    func playSound()
}

final class DefaultAudioPlayer: AudioPlayerService {
    private var player: AVAudioPlayer?
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "click", ofType: "m4a") else { return }
        let url = URL(filePath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch (let error) {
            print("Error: \(error)")
        }
    }
}
