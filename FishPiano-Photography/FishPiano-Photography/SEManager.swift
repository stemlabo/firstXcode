//
//  SEManager.swift
//  FishPiano-Photography
//
//  Created by kyosukenakashima on 2019/04/13.
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
            print("AVAudioPlayerの作成に失敗しました!")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let index = sePool.index(of: player) {
            sePool.remove(at: index)
        }
    }
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

