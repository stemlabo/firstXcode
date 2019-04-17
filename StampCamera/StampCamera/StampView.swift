//
//  StampView.swift
//  StampCamera
//
//  Created by kyosukenakashima on 2019/04/16.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class StampView: UIImageView {
    //UIImageViewを継承
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubviewToFront( self)
    }
    
    //    touchesBeganの中(でsuperview?.bringSubviewメソッドが実装されている。
    //    selfスタンプのビューを一番上のビューにおいて一番手前に持ってくる
    //    スタンプをタップしたタイミングでそのスタンプが画面の一番手前に表示される
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        touchesMovedメソッド引数として受け取ったtouchesから画面に置かれた指の情報を取得できる
        guard let touch = touches.first else { return }
        
        let dx = touch.location(in: self.superview).x - touch.previousLocation(in: self.superview).x
        //        現在の指のx座標と直前の指のy座標の差を計算
        let dy = touch.location(in: self.superview).y - touch.previousLocation(in: self.superview).y
        self.center = CGPoint(x: self.center.x + dx, y: self.center.y + dy)
        //        指の動きだけスタンプが移動する
    }
}
