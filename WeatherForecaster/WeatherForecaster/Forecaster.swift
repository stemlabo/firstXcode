//
//  Forecaster.swift
//  WeatherForecaster
//
//  Created by kyosukenakashima on 2019/04/17.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class Forecaster: NSObject {
//    天気情報を取得し構造体にして返す役割を担っている
    
    static func forecast(cityName:String, completion:@escaping (ForecastResult)->Void){
        //        completion 処理が完了した際に実行するクロージャを受け取る　　ForecastResultという構造体を引数としてわたす　　この場合クロージャが他のクロージャの中で実行されるので@escapingと書く
//cityName 町の名前
        
        let appID = "08300cbc55bdcce017b27ab85a379446"
//openweathermapのAPI  key
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?units=metric&q=" + cityName + "&APPID=" + appID
        guard let url = URL(string: urlString) else {
//            URLのし作成に失敗した場合ここでメソッドを終了させることができる
            print("URL error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            通信のタスクがつくられる。data, response, errorを引数として受け取る
//            inの後　通信終了後の処理
            guard let jsonData = data else {
                print("JSON data error")
                return
            }
//       guard を使ってオプショナル型ではない
            do {
                let result:ForecastResult = try JSONDecoder().decode(ForecastResult.self, from: jsonData)
                completion(result)
//                jsonDataをJSONDecoder().decodeでForecastResultの構造体に落とし込む
//ForecastResult.selfとjsonDataを引数としてh渡す
            }catch let error{
                print(error)
            }
        }
        task.resume()
//        これらのタスクを実行
    }
}

struct ForecastResult: Codable{
    var list:[Forecast]
//構造体Forecastという配列
}

struct Forecast: Codable {
    var dt_txt:String
    var main:Main
    var weather:[Weather]
    
    struct Main: Codable {
        var temp: Double
        var pressure: Double
        var humidity: Int
    }
    
    struct Weather: Codable {
        var description: String
        var id: Int
        var main: String
    }
    
    //課題追加　気圧と湿度
    func getFormattedPressure() -> String{
        return String(format: "%.2f hPa", main.pressure)
    }
    
    func getFormattedHumidity() -> String{
        return String(format: "Humidity: %d ％", main.humidity)
    }
    
    
    
    func getFormattedTemp() -> String{
        return String(format: "%.1f ℃", main.temp)
//        少数の桁を揃えて度Cをつける
    }
    
    func getDescription() -> String{
        return weather.count > 0 ? weather[0].description : ""
        // ?:を使って三項演算子　要素数が0であれば "" 0以上であれば最初の要素のdescriptionを返す
    }
    
    func getIconText() -> String {
//        アイコンを文字列で返す
        if weather.count == 0 {
            return ""
        }
        // 次を参考: https://openweathermap.org/weather-conditions
        switch weather[0].id {
        case 200..<300: return "⚡️"
        case 300..<400: return "🌫"
        case 500..<600: return "☔️"
        case 600..<700: return "⛄️"
        case 700..<800: return "🌪"
        case 800: return "☀️"
        case 801..<900: return "☁️"
        case 900..<1000: return "🌀"
        default: return "☁️"
        }
    }
    
    func getMain() -> String {
        return weather.count > 0 ? weather[0].main : ""
//        mainプロパティ(天気を表す単語が入っている）を返す
    }
}
