//
//  ViewController.swift
//  ActionGame
//
//  Created by kyosukenakashima on 2019/04/15.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
            // ハイスコアの読み込み
    override func viewWillAppear(_ animated: Bool) {
        let ud = UserDefaults.standard
        let highScore = ud.integer(forKey: "HiScore")
        highScoreLabel.text = "\(highScore)"
        // 存在しない場合は0
//        forKeyでハイスコアが読み込まれ
//        ハイスコアラベルに表示される
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

