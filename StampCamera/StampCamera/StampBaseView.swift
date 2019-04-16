//
//  StampBaseView.swift
//  StampCamera
//
//  Created by kyosukenakashima on 2019/04/16.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//


import UIKit

class StampBaseView: UIView {
    //    UIViewを継承
    
    @IBOutlet var backgroundImageView: UIImageView!
    //    backgroundImageViewをUIImageView!と紐づける
    
    func setBackgroundImage(image: UIImage){
        backgroundImageView.image = image
    }
    //    setBackgroundImageメソッド　背景画像の設定
    func addStamp(stampImage: UIImage){
        //        addStampメソッド　画面にスタンプに追加
        //        スタンプのイメージを引数として受けた上で
        let size = 100
        //        サイズを指定
        let stampView = StampView()
        //StampViewのインスタンスを生成
        stampView.image = stampImage
        //イメージ
        stampView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        //フレーム
        stampView.center = self.center
        //        初期位置
        stampView.isUserInteractionEnabled = true
        //        trueとすることでスタンプに対してユーザーの操作が可能になる
        self.addSubview(stampView)
        //        addSubviewによりstampViewに追加される
    }
    
    func deleteStamp(){
        if let topStamp = self.subviews.last as? StampView {
            topStamp.removeFromSuperview()
            //deleteStampメソッド　stampViewの一番手前のスタンプを取得
            //removeFromSuperviewで削除
        }
    }
    
    func saveImageWithStamps(){
        //        背景画像とスタンプを結合した画像を取得しフォトアルバムに保存
        UIGraphicsBeginImageContextWithOptions(self.frame.size, self.isOpaque, 0.0)
        //イメージコンテキストが開始
        guard let context = UIGraphicsGetCurrentContext() else { return }
        self.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        //        イメージコンテキストを終了
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        //画像をフォトアルバムに保存
    }
}
