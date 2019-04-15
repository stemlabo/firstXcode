//
//  ViewController.swift
//  MarioGame
//
//  Created by kyosukenakashima on 2019/04/16.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // ハイスコアの読み込み
        let ud = UserDefaults.standard
        let highScore = ud.integer(forKey: "HiScore") // 存在しない場合は0
        highScoreLabel.text = "\(highScore)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

