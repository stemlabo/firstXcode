//
//  Fish.swift
//  MarioGame
//
//  Created by kyosukenakashima on 2019/04/16.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class Fish: UIImageView {
    
    var bottom: CGFloat = 0 
    var top: CGFloat = 0
    
    var vSpeed: CGFloat = 0
    
    func move(){
        vSpeed += 0.3
        self.center = CGPoint(x: self.center.x, y: self.center.y + vSpeed)
        
        if self.center.y > bottom {
            vSpeed = -9
        }else if self.center.y < top {
            self.center = CGPoint(x: self.center.x, y: top)
            vSpeed = 0
        }
    }
    
    func jump(){
        vSpeed = -6
    }
}

