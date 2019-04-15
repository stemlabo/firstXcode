//
//  PlayViewController.swift
//  ActionGame
//
//  Created by kyosukenakashima on 2019/04/15.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    var screenWidth: CGFloat!
//    画面の幅
    var screenHeight: CGFloat!
 //    画面の高さ
    var frameTimer: Timer!
//    主人公や敵キャラを移動させたり　あたり判定につかう
    var score = 0
//    得点
    var scoreCount = 0
    //    得点入るまでカウントするのにつかう
    let scroreInteval = 60
       //    得点入るまでの間隔
    var enemyCount = 0
//    敵が出現するまでカウントされる
   var enemyInterval = 60
           //    敵が出現するまでの間隔
    var enemyArray = [Enemy]()
//    敵を格納する配列
    
    @IBOutlet var fish: Fish!
//    主人公のラベル
    @IBOutlet var scoreLabel: UILabel!
    //   得点を表示するラベル
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenWidth = self.view.frame.size.width
        screenHeight = self.view.frame.size.height
//        画面の幅と高さにする
        
        fish.bottom = self.view.frame.size.height - 50
        fish.top = 50
//        画面のはしと上からの余白を50とっている
        
        frameTimer = Timer.scheduledTimer(withTimeInterval: 1.0/60, repeats: true, block: { (timer) in
            self.frameAction()
        })
        
//        scheduledTimerで行って間隔で処理を実行　1.0/60 １秒間に60回　　repeats: trueで繰り返し
//        実際に行われる処理はblockの中に書くframeAction()メソッドが１秒間に60回実行される
        
        fish.animationImages = [UIImage(named:"fish1.png")!, UIImage(named:"fish2.png")!]
        fish.animationDuration = 0.5
        fish.startAnimating()
//fish1.pngfish2.pngを0.5秒間隔で入れ替えるアニメ〜ション
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fish.jump()
        //    画面に指を置いた際に実行される
    }

    func frameAction(){
        
        fish.move()
        
        for i in (0..<enemyArray.count).reversed() {
            // reversed()で逆ループ　配列の最後の要素から最初の要素にまわす
//逆ループすることで、要素の番号が変わることはない
            
            let enemy = enemyArray[i]
//            配列からenemyをとりだす
            enemy.move()
            
            // 衝突判定
            if abs(fish.center.x - enemy.center.x) < 50 && abs(fish.center.y - enemy.center.y) < 50 {
//                主人公と敵が５０以下の距離になったらゲームを終了させる
                // 絶対値で判定
                finishGame()
                return
            }
            
            // 画面外の敵は除去
            if enemy.center.x < -enemy.frame.size.width/2 {
                enemyArray.remove(at: i)
                enemy.removeFromSuperview()
            }
        }
//        敵が画面から半分はみ出したらenemyArrayからこの要素を削除する
//removeFromSuperview()で親のviewからもさくじょする
        // 敵の発生
        if enemyCount >= enemyInterval {
            let size:CGFloat = 60
            //            敵のサイズ
            let enemy = Enemy()
            //enemyのインスタンスを生成
            enemy.frame = CGRect(x: 0, y: 0, width: size, height: size)
            //            敵の出現位置を決める
            let randY = arc4random_uniform(500)
                  //            敵の出現位置をランダムにする
            enemy.center = CGPoint(x: screenWidth + size/2, y: CGFloat(randY))
//            敵の出現場所　画面右端にkギリギリ隠れる　　y座標はrandY
            enemy.bottom = self.view.frame.size.height - 40
            enemy.top = 40
            self.view.addSubview(enemy)
//画面上に敵を追加
            enemyArray.append(enemy)
//            enemyArrayのにenemyを追加
            enemyCount = 0
//            ０にリセット
// 敵の出現間隔を短くする
            enemyInterval = Int(Double(enemyInterval) * 0.9)
            if enemyInterval < 20 {
                enemyInterval = 20
            }
        }else{
            enemyCount += 1
//            enemyCount < enemyIntervalの場合増加させる
        }
        
    
// スコア
        if scoreCount >= scroreInteval {
            score += 1
            scoreLabel.text = "\(score)"
//            スコアラベルにスコアを表示させる
            scoreCount = 0
//            そのさいに０にリセット
        }else{
            scoreCount += 1
    //      scoreCount < scroreInteval １増加させる
        }
    }
    
    
    func finishGame(){
//
        frameTimer.invalidate()
//        タイマーの停止
        fish.stopAnimating()
      //        アニメーションの停止
        // ハイスコアの保存
        let ud = UserDefaults.standard
//スコアの保存に使うメソッド　UserDefaults
        let highScore = ud.integer(forKey: "HiScore")
//integer(forKey: "HiScore") ハイスコアを読み込む
        // 存在しない場合は0
        
        if score > highScore {
            ud.set(score, forKey: "HiScore")
        }
//       今回にスコアがハイスコアより大きかった場合、forKey:をつかってハイスコアを保存する
        ud.synchronize()
//        synchronize()メソッドで即保存される
        UIView.animate(withDuration: 0.7, animations: {
            self.fish.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }) { (_) in
            UIView.animate(withDuration: 0.7, animations: {
                self.fish.transform = CGAffineTransform.identity
            }) { (_) in
                self.dismiss(animated: true, completion: nil)
//        dismissメソッドで       画面をとじる
            }
        }
        
    }
    
}
