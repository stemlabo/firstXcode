//
//  ViewController.swift
//  SlimeMarker
//
//  Created by kyosukenakashima on 2019/04/19.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

//SceneKit 3Dキッドを扱う
//ARを扱う

class ViewController: UIViewController, ARSCNViewDelegate {
//    ARSCNViewDelegateをプロトコルとして導入
    
    @IBOutlet var sceneView: ARSCNView!
    
//    sceneViewは、ARSCNView!と紐づけられている
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
// デリゲートの設定
        sceneView.delegate = self
        
// デバッグ用の情報の表示
        sceneView.showsStatistics = true
//        画面下部にAR関係の情報を表示する
        sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
//     黄色い点で特徴点が表示される
        
// シーンの作成room.scn
        let scene = SCNScene(named: "art.scnassets/room.scn")!
        
// シーンをsceneViewに設定
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        画面が表示されるタイミングで実行されるメソッド
        
        // 平面を検知するための設定
        let configuration = ARWorldTrackingConfiguration()
//        ARWorldTrackingConfigurationのインスタンスを生成し
        configuration.planeDetection = .horizontal
//        プロパティのplaneDetectionにhorizontalを設定
        
        // セッションの開始
        sceneView.session.run(configuration)
        //        ARのセッションを開始する際にrunで開始
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        画面が消えるタイミングで実行されるメソッド
        super.viewWillDisappear(animated)
//        ARのセッションを開始する際に
        
        // セッションの停止
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
// 電池消費量がおおいので
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: sceneView) else {
// 画面に指を置いた際にj実行される
//            指を置いた位置を取得
            return
        }
//  取得できない場合
        
        let hitTestResult = sceneView.hitTest(location, types: .existingPlane)
//        hitTestは平面の検知locationとtypesを引数と指定しexistingPlaneを選択
        if let result = hitTestResult.first {
            
            let material = SCNMaterial()
//            SCNMaterialにmaterialが生成される　3Dオブジェクトの表面を生成
            material.diffuse.contents = UIImage(named: "art.scnassets/blue_slime_texture.png")
//            diffuse.contentsにテクスチュアの画像をせってい
            let geometry = SCNSphere(radius: 0.1)
//            半径をしてい
            geometry.materials = [material]
//            球体のgeometryを作成materialを配列で設定
            // ノードを作成し追加
            let node = SCNNode(geometry: geometry)
//            seanにノードを追加することで3Dオブジェクトがシーンに配置される
            node.position = SCNVector3(result.worldTransform.columns.3.x, result.worldTransform.columns.3.y, result.worldTransform.columns.3.z)
//            hittestの値をworldT座標に変換
            sceneView.scene.rootNode.addChildNode(node)
//            作成したノードを親のノードへaddChildNodeで追加
            
            // ノードを回転させる
            node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.5, z: 0, duration: 1)))
//            SCNAction.rotateBy 回転
        }
    }
}
