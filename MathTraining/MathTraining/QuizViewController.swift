//
//  QuizViewController.swift
//  MathTraining
//
//  Created by kyosukenakashima on 2019/04/08.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    let total = 10 // 問題数
    var correct = 0 //正解数
    var questionIndex = 0 //問題の番号
    var answerIndex = 0 //正解の数
    
    //ストーリーボード上のラベルと紐づける変数
    @IBOutlet var leftNumberLabel: UILabel!
    @IBOutlet var centerNumberLabel: UILabel!
    @IBOutlet var rightNumberLabel: UILabel!
    
    //問題を設定するためのメソッド
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //画面が読み込まれた段階で問題が設定される setQuestions()
        setQuestions()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //演算子のボタンが押された時の処理
    
    @IBAction func tapped(sender: UIButton) {
        //正解の判定
        if sender.tag - 1 == answerIndex {
            correct += 1
            //演算子のボタンに１−４のタグをつけた。-1することで0-3までの番号、それがアンサーインデックスと等しければ正解とみなしてコレクトを一つ増やす(正解が１つ増える)
        }
        
        questionIndex += 1
        if questionIndex >= total {
            performSegue(withIdentifier: "QuizToResult", sender: nil)
        }else {
            setQuestions()
        }
    }
    
        //arc4randomにより0~10の間の乱数を表示　（左のラベル)
    func setQuestions() {
        let leftNum = Int(arc4random_uniform(10))
        var centerNum = Int(arc4random_uniform(10))
        //0~3までの４とうりの値
        answerIndex = Int(arc4random_uniform(4))
        switch answerIndex {
        case 0:
            rightNumberLabel.text = "\(leftNum + centerNum)"
        case 1:
            rightNumberLabel.text = "\(leftNum - centerNum)"
        case 2:
            rightNumberLabel.text = "\(leftNum * centerNum)"
        default:
            if centerNum == 0 {
                centerNum = 1
            }
            rightNumberLabel.text = "\(leftNum / centerNum)"
            }
     
    //left centerナンバーラベルに数字を表示
    leftNumberLabel.text = "\(leftNum)"
    centerNumberLabel.text = "\(centerNum)"
}
   }
