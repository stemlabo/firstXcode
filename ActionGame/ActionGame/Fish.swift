//
//  Fish.swift
//  ActionGame
//
//  Created by kyosukenakashima on 2019/04/15.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class Fish: UIImageView {
    
//UIImageViewを継承
    
    var bottom: CGFloat = 0
    // 表示位置の下限のy座標
    var top: CGFloat = 0
    // 表示位置の上限のy座標
    
    var vSpeed: CGFloat = 0
    // 垂直方向の速度
    
    func move(){
//        主人公を動かすために使うメソッド
        vSpeed += 0.3
//        メソッドが実装されるたびに0.3増加する
        self.center = CGPoint(x: self.center.x, y: self.center.y + vSpeed)
//vSpeedの分だけキャラクターのY座標が変化する
        
        if self.center.y > bottom {
//            Y座標がボトムより大きくなった場合　キャラクターが画面上の下限より低くなった場合vSpeedを-10(上に向かって跳ねる)
            
            vSpeed = -10
        }else if self.center.y < top {
            self.center = CGPoint(x: self.center.x, y: top)
            vSpeed = 0
//            キャラクターが画面より上にある場合、キャラクターのY座表を画面の上限の位置とする
//vSpeedを0
//            画面内に収まるような設定
        }
    }
    
    func jump(){
        vSpeed = -10
    }
//    画面んをタップするたびにキャラクターが跳ねる
}
