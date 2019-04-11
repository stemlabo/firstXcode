//
//  ViewController.swift
//  Animation
//
//  Created by kyosukenakashima on 2019/04/11.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
//    イメージビュー（ストーリーボード状のイメージビュウと紐づける）

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

//ボタンがタップされた際の処理
    @IBAction func buttonTapped(sender: UIButton) {
        
//        UIView.animate(withDuration: 1.0) {
//            self.imageView.transform = CGAffineTransform(translationX: 0, y: -100)
//               }
            //UIViewの持っているanimateクラスメソッド　第１引数1.0 第2引数クロージャ　アニメーションの終了後の状態を記述　{クロージャはの外にかける　　クロージャの中でクラスのインスタンス変数にアクセスするためには変数の前にself transformプロパティを変更する　　y方向は下に行くほど大きくなる(逆）
  
//        UIView.animate(withDuration: 1.0, animations: {
//            self.imageView.transform  = CGAffineTransform(translationX: 0, y: -100)
//        }) { (_) in
 //           self.imageView.transform = CGAffineTransform.identity
 //       }
        //identityは元の位置に戻ることを意味する。　第１引数のクロージャではアニメーション終了後の状態
         //コンプリーションのクロージャでは、終了後に行う動作
    
    
//        UIView.animate(withDuration: 1.0, animations: {
//            self.imageView.transform = CGAffineTransform(translationX: 0, y: -100)
//        }) { (_) in
//            UIView.animate(withDuration: 1.0, animations: {
//                self.imageView.transform = CGAffineTransform.identity
//            })
//        }
    
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: .curveLinear, animations: {
            self.imageView.transform = CGAffineTransform(translationX: 0, y: 100)
        }) { (_) in
            UIView.animate(withDuration: 1.0, animations: {
                self.imageView.transform = CGAffineTransform.identity
            })
        }
    
    //Damping: 0.5,Velocity: 0.5,はバネのような動きの物理定数
    
        }
      }

