//
//  LoginViewController.swift
//  Happystagram
//
//  Created by 真田雄太 on 2018/01/21.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func creatNewUser(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(user,error) in
        
        //新規ユーザー登録
            //if self.emailTextField.text == nil || self.passwordTextField.text == nil{
            if error == nil {
                
                UserDefaults.standard.set("check", forKey: "check")
                
                self.dismiss(animated: true, completion: nil)
            
            }else{
                //失敗
                let alertViewController = UIAlertController(title: "おっと", message: "入力欄が空です。", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                
                alertViewController.addAction(okAction)
                
                self.present(alertViewController, animated: true, completion: nil)
                
            }
        })
    }
    
    
    @IBAction func userLogin(_ sender: Any) {
        
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(user,error) in
                
                if error == nil{
                    
                    
                    
                }else{
                    
                    let alertViewController = UIAlertController(title: "おっと", message: "入力欄が空です。", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                    
                    alertViewController.addAction(okAction)
                    
                    self.present(alertViewController, animated: true, completion: nil)
                    
                }
            })
    
    }}
