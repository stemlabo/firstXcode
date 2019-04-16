//
//  ViewController.swift
//  StampCamera
//
//  Created by kyosukenakashima on 2019/04/16.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, StampSelectViewControllerDelegate {
    
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
    }
    
    @IBAction func cameraTapped(sender: UIButton) {
        showSourceSelection()
    }
    
    @IBAction func stampTapped(sender: UIButton) {
        performSegue(withIdentifier: "MainToStamp", sender: nil)
    }
    
    @IBAction func deleteTapped(sender: UIButton) {
        stampBaseView.deleteStamp()
    }
    
    @IBAction func saveTapped(sender: UIButton) {
        confirmSave()
    }
    
    func showSourceSelection() {
        let alert = UIAlertController(title:"写真を選択", message: "ソースを選んでください", preferredStyle: .alert)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
            (action: UIAlertAction!) in
            self.pickImage(sourceType: .camera)
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
    
    func pickImage(sourceType: UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            stampBaseView.setBackgroundImage(image: pickedImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func confirmSave(){
        let alert = UIAlertController(title:"確認", message: "画像を保存しますか？", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "保存", style: .default, handler: {
            (action: UIAlertAction!) in
            self.stampBaseView.saveImageWithStamps()
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

