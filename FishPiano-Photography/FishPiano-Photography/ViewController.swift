//
//  ViewController.swift
//  FishPiano-Photography
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

    @IBAction func play(sender :UIButton){
        
        SEManager.shared.play(fileName: "\(sender.tag).mp3") // tagでタッチしたボタンを識別
        
// パラパラアニメの設定
        sender.imageView?.animationImages = [UIImage(named:"fish1.png")! , UIImage(named:"fish2.png")!]
        sender.imageView?.animationDuration = 0.2
        sender.imageView?.startAnimating()
        
       
        UIView.animate(withDuration: 0.5, animations: {
// 0.5秒でアニメーション
           
            
//回転と移動を合成
            sender.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2).concatenating(CGAffineTransform(translationX: 0, y: -150))
        }) { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                sender.transform = CGAffineTransform.identity // 元の状態に戻す
            }) { (_) in
                sender.imageView?.stopAnimating()
//パラパラアニメの終了
            }
        }
    }
}

