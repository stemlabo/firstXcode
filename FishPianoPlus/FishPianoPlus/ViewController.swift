//
//  ViewController.swift
//  FIshPianoPlus
//
//  Created by kyosukenakashima on 2019/04/13.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func playFish(sender :UIButton){
        play(tag: sender.tag)
    }

    @IBAction func playThreeFishesLeft(sender: UIButton) {
        play(tag: 1)
        play(tag: 3)
        play(tag: 5)
    }
    
    @IBAction func playThreeFishesRight(sender: UIButton) {
        play(tag: 2)
        play(tag: 4)
        play(tag: 6)
    }

    func play(tag: Int){
        
        SEManager.shared.play(fileName: "\(tag).mp3")
//        tagdeタッチしたボタンを識別
        
        let button = self.view.viewWithTag(tag) as! UIButton
        
//        パラパラアニメの設定
        button.imageView?.animationImages = [UIImage(named:"fish1.png")! ,UIImage(named:"fish2.png")!]
        button.imageView?.animationDuration = 0.2
        button.imageView?.startAnimating()
        
        UIView.animate(withDuration: 0.5, animations: {
            //回転、移動、拡大を合成
            button.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2).concatenating(CGAffineTransform(translationX: 0, y: -50)).concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
        }) { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                button.transform = CGAffineTransform.identity // 元の状態に戻す
            }) { (_) in
                button.imageView?.stopAnimating() //パラパラアニメの終了
            }
        }
    }
}

