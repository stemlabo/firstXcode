//
//  ViewController.swift
//  tubuyakimushi
//
//  Created by kyosukenakashima on 2019/04/19.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

enum SlimeType {
    case blue
    case red
}

class ViewController: UIViewController, ARSCNViewDelegate {
    
    var slimeType: SlimeType = .blue
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // デリゲートの設定
        sceneView.delegate = self
        
        // デバッグ用の情報の表示
        sceneView.showsStatistics = true
        sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        
        // シーンの作成
        let scene = SCNScene(named: "art.scnassets/room.scn")!
        
        // シーンをsceneViewに設定
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 平面を検知するための設定
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // セッションの開始
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // セッションの停止
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: sceneView) else {
            return
        }
        
        // 平面の検知
        let hitTestResult = sceneView.hitTest(location, types: .existingPlane)
        if let result = hitTestResult.first {
            
            let material = SCNMaterial()
            switch slimeType {
            case .blue:
                material.diffuse.contents = UIImage(named: "art.scnassets/blue_slime_texture.png")
                slimeType = .red
            case .red:
                material.diffuse.contents = UIImage(named: "art.scnassets/red_slime_texture.png")
                slimeType = .blue
            }
            
            let geometry = SCNSphere(radius: 0.1)
            geometry.materials = [material]
            
            // ノードを作成し追加
            let node = SCNNode(geometry: geometry)
            node.position = SCNVector3(result.worldTransform.columns.3.x, result.worldTransform.columns.3.y, result.worldTransform.columns.3.z)
            sceneView.scene.rootNode.addChildNode(node)
            
            // ノードを回転させる
            node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.5, z: 0, duration: 1)))
        }
    }
}
