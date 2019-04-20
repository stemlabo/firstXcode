//
//  ViewController.swift
//  ObjectRecognitionPlus
//
//  Created by kyosukenakashima on 2019/04/21.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit
import AVFoundation
// ビデオの入出力用フレームワーク
import Vision
// Vision コアmlをベースとした物体認識フレームワーク

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
//    AVCaptureVideoDataOutputSampleBufferDelegate プロトコルが導入　カメラで撮影された毎フレームごとに処理を実装
    var recognitionInterval = 0
// 変数recognitionIntervalは物体認識を行う間隔
    
    var mlModel:VNCoreMLModel?
// VNCoreMLModelを型にしてCoreMLのモデルを扱う
    
    @IBOutlet var textView: UITextView!
    //変数textViewは、しストーリーボード上のUITextView!と紐付け
    @IBOutlet var segmentControl: UISegmentedControl!
    
//    課題追加
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setVideo()
        setModel(index: segmentControl.selectedSegmentIndex)
        //        初期設定
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setVideo(){
        // セッションの設定
        let session = AVCaptureSession()
        //AVCaptureSessionは、ビデオのキャプチャーを管理するクラス　インスタンスを生成
        session.sessionPreset = AVCaptureSession.Preset.photo
        //        画像のクオリティ　Preset.photoを設定
        // ビデオ入力の設定
        let device = AVCaptureDevice.default(for: .video)
        //        AVCaptureDevice.defaultで設定をvideoにしデバイスを取得
        guard let input = try? AVCaptureDeviceInput(device: device!) else {
            //            AVCaptureDeviceInputによりdevice!を用いてinputを作成
            return
        }
        if session.canAddInput(input) {
            //            canAddInputで追加可能であればsessionにinputを追加
            session.addInput(input)
        }
        
        // ビデオ出力の設定
        let output = AVCaptureVideoDataOutput()
        //        AVCaptureVideoDataOutputによりOutputを作成
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "VideoQueue"))
        //        setSampleBufferDelegate   引数にself・VideoQueueを渡す
        //        Queueとは実行すべき処理を複数重ねたもの
        //        デリゲートを設定することで毎フレームごとにデリゲートメッソドで画像データを受け取ることができる
        if session.canAddOutput(output) {
            //sessionにoutputが追加可能であればaddOutputで追加
            session.addOutput(output)
        }
        
        // プレビューの設定
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        //        セッションを指定しpreviewLayer を作成する。　実際に描画が行われる
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //videoの長方形にたいしてvideoをどのように描画するかの設定　resizeAspectFillを設定
        previewLayer.frame = view.bounds
        //layerの位置とサイズをviewの位置とサイズに一致させる
        view.layer.insertSublayer(previewLayer, at: 0)
        //        insertSublayerによりviewのlayerに挿入される
        // ビデオの取得開始
        session.startRunning()
    }
    
    func setModel(index: Int){
        // CoreMLのモデルクラスの初期化
        //        モデルのファイルの中のクラスを指定
//        課題追加
        switch index {
        case 0:
            mlModel = try? VNCoreMLModel(for: MobileNet().model)
        case 1:
            mlModel = try? VNCoreMLModel(for: GoogLeNetPlaces().model)
        default:
            mlModel = try? VNCoreMLModel(for: SqueezeNet().model)
        }
    }
    
    // ビデオのフレームごとに呼ばれるメソッド
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        // 物体認識を行うのは20フレームに一回
        if recognitionInterval < 20 {
            recognitionInterval += 1
            return
        }
        recognitionInterval = 0
        
        // CMSampleBufferをCVPixelBufferに変換
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer), let model = mlModel else {
            return
        }
        
        // 画像認識のリクエストを作成 モデルと結果の取得後の処理を渡す
        let request = VNCoreMLRequest(model: model) {
            (request: VNRequest, error: Error?) in
            
            // 識別結果をVNClassificationObservationの配列で取得
            guard let results = request.results as? [VNClassificationObservation] else {
                return
            }
            
            // 識別結果と信頼度を上位5件表示
            var displayText = ""
            for result in results.prefix(5) {
                displayText += "\(Int(result.confidence*100))% " + result.identifier + "\n"
            }
            
            // textViewに結果を表示（メインスレッドで実行）
            DispatchQueue.main.async {
                self.textView.text = displayText
            }
        }
        
        // CVPixelBufferに対し、画像認識リクエストを実行
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        setModel(index: sender.selectedSegmentIndex)
    }
}
//課題追加

