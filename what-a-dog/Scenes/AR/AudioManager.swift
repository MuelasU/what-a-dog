//
//  AudioManager.swift
//  tumbalacatum
//
//  Created by Paulo Bassani on 09/02/22.
//

import AVFoundation
import Foundation

class AudioManager {
    public static var shared = AudioManager()
    private var bark: AVAudioPlayer?
    private var musicPlayer: AVAudioPlayer?

    private var generalVolume: Float {
        willSet(newValue) {
            updateMusicVolume(generalVolume, newValue)
        }
    }

    private init() {
        generalVolume = 0.5
    }

    public func setMainVolume(value: Float) {
        if value == 0 {
            return
        }
        generalVolume = value
    }

    func playBark() {
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            if let url = Bundle.main.url(forResource: "Bark", withExtension: "wav") {
                do { bark = try AVAudioPlayer(contentsOf: url) } catch {}
                bark?.volume = 1
                bark?.play()
            }
        }
    }

    private func updateMusicVolume(_ value: Float, _ newValue: Float) {
        let musicVolume = (musicPlayer?.volume)! / value
        musicPlayer?.volume = musicVolume * newValue
    }
}
