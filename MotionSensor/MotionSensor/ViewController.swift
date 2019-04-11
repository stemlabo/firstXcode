//
//  ViewController.swift
//  MotionSensor
//
//  Created by kyosukenakashima on 2019/04/11.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let motionManager = CMMotionManager()
//    モーションセンサー全般を取り扱う
    @IBOutlet var fish: UIImageView!
//    変数FIshはストーリーボード状のイメージヴューに対応

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let originalX =  fish.center.x
        
        
        if motionManager.isDeviceMotionAvailable {
//            モーションセンサーが利用可能かどうかを判定
            motionManager.deviceMotionUpdateInterval = 0.02
//            モーションを検知する間隔　0.02秒に1回
//       ↓↓current!で現在のキューを取得　モーションセンサのy処理を行う為のキューを指定
//            モーションの中からroll     モーションはオプショナル型なのでnill出ないことを明記
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler:
                { (motion, error) in
                print(motion!.attitude.roll)
    //iPhoneの縦方向を軸とした傾き　-πからπまで
                let newX = originalX + CGFloat(motion!.attitude.roll * 100)
//  上記のrollを使って動かす。CGFloat型に変更したmotion 係数を100掛けるパイが座標としては値が小さすぎる為
                self.fish.center = CGPoint(x: newX, y: self.fish.center.y)
//fishの座標を変更。CGFloat型は座標を指定するのによく用いられる
                
            })
        }
    }
    func stopSensor() {
        motionManager.stopDeviceMotionUpdates()
    }

    
}

