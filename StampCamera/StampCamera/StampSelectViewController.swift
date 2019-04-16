//
//  StampSelectViewController.swift
//  StampCamera
//
//  Created by kyosukenakashima on 2019/04/16.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//


protocol StampSelectViewControllerDelegate: class { // weakを使用する際はclassの継承が必要
    func didSelectStamp(stampImage:UIImage)
}

import UIKit

class StampSelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var stampImages = [UIImage]()
    
    weak var delegate:StampSelectViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        for i in 1...4{
            if let image = UIImage(named: "stamp\(i).png") {
                stampImages.append(image)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stampImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StampCell", for: indexPath)
        
        if let stampImageView = cell.viewWithTag(1) as? UIImageView {
            stampImageView.image = stampImages[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectStamp(stampImage: stampImages[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}
