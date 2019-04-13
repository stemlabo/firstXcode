//
//  SEManager.swift
//  OtokoQuiz
//
//  Created by kyosukenakashima on 2019/04/14.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

import AVFoundation

class SEManager: NSObject, AVAudioPlayerDelegate {
    
    
    static let shared = SEManager()
    var sePool = [AVAudioPlayer]()
    
    func play(fileName: String){
        let url = URL(fileURLWithPath: Bundle.main.bundlePath).appendingPathComponent(fileName)
        let player:AVAudioPlayer!
        do {
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint:nil)
            player.delegate = self
            sePool.append(player)
            player.play()
        } catch  {
            print("AVAudioPlayerの作成に失敗しました")
        }
    }
    
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let index = sePool.index(of: player) {
            sePool.remove(at: index)
        }
    }
}
