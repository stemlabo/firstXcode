//
//  DetailViewController.swift
//  WeatherForecaster
//
//  Created by kyosukenakashima on 2019/04/17.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var forecast:Forecast?
//    構造体Forecast?を受け取る
    
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var iconLabel:UILabel!
    @IBOutlet var weatherLabel:UILabel!
    @IBOutlet var descLabel:UILabel!
//    説明を表示するラベル
    @IBOutlet var tempLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        dateLabel.text = forecast?.dt_txt
        iconLabel.text = forecast?.getIconText()
        weatherLabel.text = forecast?.getMain()
        descLabel.text = forecast?.getDescription()
        tempLabel.text = forecast?.getFormattedTemp()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
