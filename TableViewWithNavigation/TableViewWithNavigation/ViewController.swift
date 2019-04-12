//
//  ViewController.swift
//  TableViewWithNavigation
//
//  Created by kyosukenakashima on 2019/04/12.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let animals = ["Dog 🐶", "Cat 🐱", "Panda 🐼", "Lion ライオン", "Snake 🐍"]
    
    @IBOutlet var animalTableView: UITableView!
//Tableviewにコンテンツを表示するにはデリゲートパターン　２つのプロトコルが必要⤴︎
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//Tableviewになんらかの操作があった時に実行
        animalTableView.dataSource = self
        animalTableView.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController, let indexPath = sender as?
            IndexPath {
            detailVC.message = animals[indexPath.row]
         }
    }
//segueが引数とわして渡される。segueに次の画面の情報が入っている
//    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
//   TableViewに表示するセルの数     配列animalsの要素数をTableViewのセルの数にする
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath)
//引数としてtableView その際現在利用可能なセル　AnimalCell indexPathでどの位置にいるセルなのか指定
        let label = cell.viewWithTag(1) as? UILabel
        label?.text = animals[indexPath.row]
//        Labelにつけたタグ１　UIラベル型にキャスト　UILabelをUIビューを継承しているのでas(オプショナル型）を使ってキャスト　　　　indexPath.rowで上から何行目かを指定できる
    
        return cell
//labelを設定した上でrerturnでこのセルを返す　コンテンツが表示されるメソッド
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MainToDetail", sender: indexPath)
//        各セルをタップしたタイミングで次の画面に遷移させる　SegueのIDを指定しなんばんめがタップされたか判別する為にindexPath
    }

}
