//
//  PlayViewController.swift
//  MarioGame
//
//  Created by kyosukenakashima on 2019/04/16.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    var frameTimer: Timer!
    
    var score = 0
    var scoreCount = 0
    let scroreInteval = 60
    
    var enemyCount = 0
    var enemyInterval = 120
    var enemyArray = [Enemy]()
    
    @IBOutlet var fish: Fish!
    @IBOutlet var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenWidth = self.view.frame.size.width
        screenHeight = self.view.frame.size.height
        
        fish.bottom = self.view.frame.size.height - 50
        fish.top = 50
        
        frameTimer = Timer.scheduledTimer(withTimeInterval: 1.0/60, repeats: true, block: { (timer) in
            self.frameAction()
        })
        
        fish.animationImages = [UIImage(named: "fish1.png")!, UIImage(named: "fish2.png")!]
        fish.animationDuration = 0.5
        fish.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fish.jump()
    }
    
    func frameAction(){
        
        fish.move()
        
        for i in (0..<enemyArray.count).reversed() { // reversed()で逆ループ
            
            let enemy = enemyArray[i]
            enemy.move()
            
            // 衝突判定
            if abs(fish.center.x - enemy.center.x) < 50 && abs(fish.center.y - enemy.center.y) < 50 { // 絶対値で判定
                finishGame()
                return
            }
            
            // 画面外の敵は除去
            if enemy.center.x < -enemy.frame.size.width/2 {
                enemyArray.remove(at: i)
                enemy.removeFromSuperview()
            }
        }
        
        // 敵の発生
        if enemyCount >= enemyInterval {
            let size: CGFloat = 60
            let enemy = Enemy()
            enemy.frame = CGRect(x: 0, y: 0, width: size, height: size)
            let randY = arc4random_uniform(500)
            enemy.center = CGPoint(x: screenWidth + size/2, y: CGFloat(randY))
            enemy.bottom = self.view.frame.size.height - 40
            enemy.top = 40
            self.view.addSubview(enemy)
            enemyArray.append(enemy)
            enemyCount = 0
            
            // 敵の出現間隔を短くする
            enemyInterval = Int(Double(enemyInterval) * 0.9)
            if enemyInterval < 20 {
                enemyInterval = 20
            }
        }else{
            enemyCount += 1
        }
        
        // スコア
        if scoreCount >= scroreInteval {
            score += 1
            scoreLabel.text = "\(score)"
            scoreCount = 0
        }else{
            scoreCount += 1
        }
    }
    
    func finishGame(){
        frameTimer.invalidate()
        fish.stopAnimating()
        
        // ハイスコアの保存
        let ud = UserDefaults.standard
        let highScore = ud.integer(forKey: "HiScore") // 存在しない場合は0
        if score > highScore {
            ud.set(score, forKey: "HiScore")
        }
        ud.synchronize()
        
        UIView.animate(withDuration: 0.7, animations: {
            self.fish.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }) { (_) in
            UIView.animate(withDuration: 0.7, animations: {
                self.fish.transform = CGAffineTransform.identity
            }) { (_) in
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
}
