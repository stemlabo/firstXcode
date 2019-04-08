//
//  QuizViewController.swift
//  MathTraining-new
//
//  Created by kyosukenakashima on 2019/04/08.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    let total = 10
    var correct = 0
    var questionIndex = 0
    var answerIndex = 0
    
    @IBOutlet var leftNumberLabel: UILabel!
    @IBOutlet var centerNumberLabel: UILabel!
    @IBOutlet var rightNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setQuestions()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? ResultViewController {
            resultVC.result = Double(correct) / Double(total) *  100.0
        }
    }
    
    @IBAction func tapped(sender: UIButton) {
        if sender.tag -  1 == answerIndex {
            correct += 1
            
        }
        
        questionIndex += 1
        if questionIndex >= total {
            performSegue(withIdentifier: "QuizToResult", sender: nil)
        }else {
            setQuestions()
        }
    }
    
    func setQuestions() {
        let leftNum = Int(arc4random_uniform(10))
        var centerNum = Int(arc4random_uniform(10))
        
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
        leftNumberLabel.text = "\(leftNum)"
        centerNumberLabel.text = "\(centerNum)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
