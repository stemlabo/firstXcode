//
//  StampSelectViewController.swift
//  StampCamera
//
//  Created by kyosukenakashima on 2019/04/16.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

protocol StampSelectViewControllerDelegate: class { // weakを使用する際はclassの継承が必要
    func didSelectStamp(stampImage:UIImage)
}
//StampSelectViewControllerDelegateプロトコル　didSelectStamp この画面でスタンプを選択した際にスタンプの選択後の処理をViewControllerで行うため
import UIKit

class StampSelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    //    UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
    
    var stampImages = [UIImage]()
    //    スタンプとして表示するイメージが入った配列
    
    weak var delegate:StampSelectViewControllerDelegate?
    //最初の画面のViewControllerをいれる（循環参照を防ぐためにweakといれる)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        for i in 1...4{
            if let image = UIImage(named: "stamp\(i).png") {
                stampImages.append(image)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    //    画面を閉じる
    
    // MARK: - Delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        numberOfItemsInSection セルの数をかえす
        return stampImages.count
        //        stampImagesに入っているイメージの数だけセルをつくる
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //      各セルの表示内容を設定  IDrとindexPathを指定してセルを取得
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StampCell", for: indexPath)
        
        if let stampImageView = cell.viewWithTag(1) as? UIImageView {
            //            タグを指定してUIImageViewを取得
            stampImageView.image = stampImages[indexPath.row]
            //        stampImagesの中に入っているセルの位置と対応させる
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectStamp(stampImage: stampImages[indexPath.row])
        //        セルの位置を指定してスタンプの情報を渡している
        self.dismiss(animated: true, completion: nil)
        //スタンプの選択画面を閉じる
    }
}
