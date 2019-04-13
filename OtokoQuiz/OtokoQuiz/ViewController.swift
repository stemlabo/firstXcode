//
//  ViewController.swift
//  OtokoQuiz
//
//  Created by kyosukenakashima on 2019/04/14.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func play(sender :UIButton){
        
        SEManager.shared.play(fileName: "\(sender.tag).mp3")
        
        }
    }

