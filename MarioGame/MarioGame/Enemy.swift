//
//  Enemy.swift
//  MarioGame
//
//  Created by kyosukenakashima on 2019/04/16.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

enum EnemyType {
    case starfish
    case squid
    case jellyfish
}

class Enemy: UIImageView {
    
    var bottom: CGFloat = 0 // 表示位置の下限のy座標
    var top: CGFloat = 0 // 表示位置の上限のy座標
    
    var enemyType: EnemyType!
    
    var hSpeed: CGFloat = 0 // 水平方向の速度
    var vSpeed: CGFloat = 0 // 垂直方向の速度
    
    override func didMoveToSuperview() {
        
        let imageNames = ["enemy1.png", "enemy2.png", "enemy3.png"]
        let rand = Int(arc4random_uniform(3))
        self.image = UIImage(named: imageNames[rand])
        
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
        }
    }
    
    func move(){
        self.center = CGPoint(x: self.center.x - hSpeed, y: self.center.y + vSpeed)
        if self.center.y > bottom {
            vSpeed = -abs(vSpeed)
        }else if self.center.y < top {
            vSpeed = abs(vSpeed)
        }
    }
    
}

