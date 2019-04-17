//
//  ViewController.swift
//  WeatherForecaster
//
//  Created by kyosukenakashima on 2019/04/17.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    UIViewControllerを継承UITableViewDelegate, UITableViewDataSource継承のプロトコルを導入
    var forecasts = [Forecast]()
//配列　Forecastの構造体
    @IBOutlet var weatherTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Forecaster.forecast(cityName: "yokohama") { (result) in
//            東京
            self.forecasts = result.list
//受け取ったresultのlistを渡している
            DispatchQueue.main.async {
// メインスレッドで実行
                self.weatherTableView.reloadData()
//受け取ったらreloadData()によりTableViewを更新
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detaiVC = segue.destination as? DetailViewController {
            detaiVC.forecast = sender as? Forecast
//            detaiVCにForecastのデータを渡す
        }
    }
    
    
//tableViewのデリゲートメソッド
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
//        numberOfRowsInSectionでTableViewのセルの数を決める
//forecastsの要素の数とする
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
//            cellForRowAt indexPathで各セルの表示内容を決める
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)
        
        let timeLabel = cell.viewWithTag(1) as? UILabel
        timeLabel?.text = forecasts[indexPath.row].dt_txt
        
        let iconLabel = cell.viewWithTag(2) as? UILabel
        iconLabel?.text = forecasts[indexPath.row].getIconText()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        didSelectRowAt indexPath セルをタップした際の処理
        performSegue(withIdentifier: "MainToDetail", sender: forecasts[indexPath.row])
//        詳細への画面遷移
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
//        各セルの高さ
    }
}

