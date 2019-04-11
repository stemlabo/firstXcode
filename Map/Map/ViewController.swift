//
//  ViewController.swift
//  Map
//
//  Created by kyosukenakashima on 2019/04/11.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var segmentControl: UISegmentedControl!
//    ストリーボード状のビューに対応
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var region = MKCoordinateRegion()
//MKCoordinateRegion()は地図を表示する構造体
        region.center = CLLocationCoordinate2DMake(35.658611, 139.745556)
//        緯度と経度を設定
        region.span.latitudeDelta = 0.02
//        範囲
        region.span.longitudeDelta = 0.02
//        緯度経度の範囲
        mapView.setRegion(region, animated: false)
//        表示範囲を変更する際にアニメーションを行うかの指定
        mapView.mapType = .standard
//mapTypeの指定　列挙型の書き方
        
    }

    @IBAction func segmentChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
//            一番左のセグメント
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid

        }
    }

}

