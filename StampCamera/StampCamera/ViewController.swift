//
//  ViewController.swift
//  StampCamera
//
//  Created by kyosukenakashima on 2019/04/16.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, StampSelectViewControllerDelegate {
    //vUINavigationControllerDelegate, UIImagePickerControllerDelegateはカメラやフォトライブラリーを制御
    //    StampSelectViewControllerDelegateはスタンプ選択画面からスタンプを受け取ってStampBaseViewに表示
    
    @IBOutlet var stampBaseView: StampBaseView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let stampSelectVC = segue.destination as? StampSelectViewController{
            stampSelectVC.delegate = self
        }
        //        次の画面にデリゲートを渡す。
    }
    
    @IBAction func cameraTapped(sender: UIButton) {
        showSourceSelection()
        //        カメラをタップした際に
    }
    
    @IBAction func stampTapped(sender: UIButton) {
        performSegue(withIdentifier: "MainToStamp", sender: nil)
    }
    //    スタンプ一覧画面への遷移
    
    //    プラスボタボタンをおすと
    @IBAction func deleteTapped(sender: UIButton) {
        stampBaseView.deleteStamp()
    }
    //    ゴミ箱ボタン
    
    @IBAction func saveTapped(sender: UIButton) {
        confirmSave()
    }
    
    //    保存　confirmSave()で確認
    
    func showSourceSelection() {
        let alert = UIAlertController(title:"写真を選択", message: "ソースを選んでください", preferredStyle: .alert)
        //        タイトルとメッセージを指定した上でアラートを設定
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
            (action: UIAlertAction!) in
            self.pickImage(sourceType: .camera)
            //           handlerとは選択時に行う処理
            //            pickImage を実行Photo Libraryを指定
        })
        
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {
            (action: UIAlertAction!) in
            self.pickImage(sourceType: .photoLibrary)
        })
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: {
            (action: UIAlertAction!) in
            print("Pick canceled")
        })
        
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    //    アラートが画面に表示される
    
    func pickImage(sourceType: UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            //            UIImagePickerControllerのインスタンスを生成
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            //    画面に結果を表示させる
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        info:に画像の情報が入っている
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //            UIImagePickerControllerOriginalImageというキーを指定してUIImage型の画像を取得
            stampBaseView.setBackgroundImage(image: pickedImage)
            //            スタンプビューの背景画像を設定
        }
        
        picker.dismiss(animated: true, completion: nil)
        //pickerを閉じる
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //imagePickerがキャンセルされた際に実行される
        picker.dismiss(animated: true, completion: nil)
    }
    
    func confirmSave(){
        let alert = UIAlertController(title:"確認", message: "画像を保存しますか？", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "保存", style: .default, handler: {
            (action: UIAlertAction!) in
            self.stampBaseView.saveImageWithStamps()
            //            結合されたものが保存される
        })
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: {
            (action: UIAlertAction!) in
            print("Save canceled")
            
        })
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Delegate methods
    func didSelectStamp(stampImage: UIImage) {
        stampBaseView.addStamp(stampImage: stampImage)
    }
}

