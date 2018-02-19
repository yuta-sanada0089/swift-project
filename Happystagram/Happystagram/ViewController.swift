//
//  ViewController.swift
//  Happystagram
//
//  Created by 真田雄太 on 2018/01/21.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UIImagePickerControllerDelegate,UITabBarDelegate,UITableViewDataSource,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "check") != nil{
            
        }else{
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "login")
            self.present(loginViewController!, animated: true, completion: nil)
        }
    }
    
    //TableViewのデリゲートメソッド
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func openCamera(){
        
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        
        //カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            //インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
        
    }
    
    func openPhoto(){
        
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
        
        //カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            //インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        
        }
    }
    
    
    @IBAction func showCamera(_ sender: Any) {
        openCamera()
    }
    
    
    @IBAction func showPhotos(_ sender: Any) {
        openPhoto()
    }
    
    
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            //backImageViewというものを初めから作っておいて、そのImageに
            //撮影された画像(アルバムで選択された画像)がデリゲートメソッドが呼ばれた時に
            //userPhotoボタンがタップされた時に、入ってるpickdImageを代入する
            //
            //backImageView.image = pickedImage
            
        }
        //カメラ画面を閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

