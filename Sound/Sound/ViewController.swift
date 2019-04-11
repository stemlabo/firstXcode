//
//  ViewController.swift
//  Sound
//
//  Created by kyosukenakashima on 2019/04/11.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit
import AVFoundation
//AVFoundationサウンドや動画の再生機能

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var player: AVAudioPlayer!
    //AAVAudioPlayer!を使う

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
//ボタンをタップした時の処理
    @IBAction func buttonTapped(sender: UIButton) {
        let url = URL(fileURLWithPath:
            Bundle.main.bundlePath).appendingPathComponent("sample.mp3")
        //音楽ファイルの場所とファイル名
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.delegate = self
            player.play()
        }catch {
            print("Failed!")
           //urlを元にAVAudioPlayerのインスタンスを作って変数playerに入れる際に失敗しエラーが出た時に対応
           //do try  catchで対応
            
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Finished!")
    }
    
    //player.delegate にViewController:のインスタンスを渡して、player側からaudioPlayerDidFinishPlayingを呼び出す
    
    
}

