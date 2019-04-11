//
//  ViewController.swift
//  ImageFilter
//
//  Created by kyosukenakashima on 2019/04/11.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    イメージビューを書く
    
    @IBOutlet var imageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//    let ciImage = CIImage(image: imageView.image!)
 //        モノクロのフィルター
          let ciImage = CIImage(image: imageView.image!)
//        コアイメージをつかって画像にフィルタをかける。コアイメージを使う為にはイメージビューで用いられてるUIイメージ
 //         型ではなく、CIイメージ型を使用(コアイメージの略)
        
  //   let filter = CIFilter(name: "CIPhotoEffectMono")!
        let filter = CIFilter(name: "CIBoxBlur")!
      
//        画像をモノクロに
        
        filter.setDefaults()
//        フィルターの状態をデフォルトに戻す
        filter.setValue(ciImage, forKey: kCIInputImageKey)
//フィルターに元の画像を指定する
        filter.setValue(30, forKey: kCIInputRadiusKey)
//        エフェクトの半径の指定
        let outputImage = filter.outputImage
//        フィルターで処理済みの画像を取得
        imageView.image = UIImage(ciImage: outputImage!)
//      取得した画像はci型なのでUI型に変換　⇨イメージビューにセットされる
    }


}

