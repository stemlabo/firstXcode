//
//  Enemy.swift
//  ActionGame
//
//  Created by kyosukenakashima on 2019/04/15.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

enum EnemyType {
    case starfish
    case squid
    case jellyfish
}

class Enemy: UIImageView {
//UIImageViewを継承
    var bottom: CGFloat = 0
    // 表示位置の下限のy座標
    var top: CGFloat = 0
    // 表示位置の上限のy座標
    
    var enemyType: EnemyType!
    
    var hSpeed: CGFloat = 0
    // 水平方向の速度
    var vSpeed: CGFloat = 0
    // 垂直方向の速度
    
    override func didMoveToSuperview() {
//        画面に追加された際に実行される
        
        let imageNames = ["enemy1.png", "enemy2.png", "enemy3.png"]
//        敵を配列に入れる
        let rand = Int(arc4random_uniform(3))
//        敵のタイプを決める
        self.image = UIImage(named: imageNames[rand])
//        乱数randに基づき敵の画像を設定
        switch rand {
        case 0:
            enemyType = .starfish
            hSpeed = 2.0
            vSpeed = 0.5
        case 1:
            enemyType = .squid
            hSpeed = 5.0
            vSpeed = 5.0
        case 2:
            enemyType = .jellyfish
            hSpeed = 2.0
            vSpeed = 2.0
        default:
            break
        }
        
        if arc4random_uniform(2) == 0 {
            vSpeed *= -1
//            arc4random_uniform(2)で０か１をランダムに取得できる
//            ０の場合　−１をけかけて反転させる　（上に進むか下に進むか半々の）
        }
    }
    
    func move(){
        self.center = CGPoint(x: self.center.x - hSpeed, y: self.center.y + vSpeed)
//x座標をhSpeedだけy座標をvSpeedだけ変化させる
        if self.center.y > bottom {
//            y座標がbottomより大きくなった時vSpeedを負の値にする
            vSpeed = -abs(vSpeed)
//vSpeedの絶対値をとり、ーをけかけることで必ず負の値になる
        }else if self.center.y < top {
//y座標がtopより小さくなった時vSpeedを正の値にする
            vSpeed = abs(vSpeed)
        }
    }
    
}

