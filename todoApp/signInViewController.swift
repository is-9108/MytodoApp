//
//  signInViewController.swift
//  todoApp
//
//  Created by Shota Ishii on 2020/05/08.
//  Copyright © 2020 is. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


class signInViewController: UIViewController {

    @IBOutlet weak var mailAdressTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var uerNameTextField: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    @IBAction func signInButton(_ sender: Any) {
        
        let email = mailAdressTextField.text!
        let password = passwordTextField.text!

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error{
                print("DEBUG_ERROR: " + error.localizedDescription)
                if error.localizedDescription == "The email address is badly formatted."{
                    print("adress")
                    let alert: UIAlertController = UIAlertController(title: "メールアドレスが正しくありません", message: nil, preferredStyle: .alert)
                    
                    let action:UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler:{
                        (action: UIAlertAction!) -> Void in
                        print("OK")
                    })
                    alert.addAction(action)
                    self.present(alert,animated: true,completion: nil)
                }else if error.localizedDescription == "An email address must be provided."{
                    print("adress")
                    let alert: UIAlertController = UIAlertController(title: "メールアドレスを入力して下さい", message: nil, preferredStyle: .alert)
                    
                    let action:UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler:{
                        (action: UIAlertAction!) -> Void in
                        print("OK")
                    })
                    alert.addAction(action)
                    self.present(alert,animated: true,completion: nil)
                }else if error.localizedDescription == "The password must be 6 characters long or more."{
                    print("password")
                    let alert: UIAlertController = UIAlertController(title: "パスワードを６文字以上入力して下さい", message: nil, preferredStyle: .alert)
                    
                    let action:UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler:{
                        (action: UIAlertAction!) -> Void in
                        print("OK")
                    })
                    alert.addAction(action)
                    self.present(alert,animated: true,completion: nil)
                }
                
                return

            }else{
                if self.uerNameTextField.text == ""{
                    print("userName")
                    let alert: UIAlertController = UIAlertController(title: "ユーザー名を入力して下さい", message: nil, preferredStyle: .alert)
                    
                    let action:UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler:{
                        (action: UIAlertAction!) -> Void in
                        print("OK")
                    })
                    alert.addAction(action)
                    self.present(alert,animated: true,completion: nil)
                    return
                }
                var ref: DocumentReference? = nil
                ref = self.db.collection("users").addDocument(data: [
                    "name" : self.uerNameTextField.text!,
                    "mailAdress" : email,
                    "password" : password
                ]){err in
                    if let err = err{
                        print("ERROR: \(err.localizedDescription)")
                    }
                }
            }
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController")
            self.present(loginViewController!,animated: true,completion: nil)
        }
        
    }
    
    @IBAction func allDelete(_ sender: Any) {
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
            // An error happened.
          } else {
            // Account deleted.
          }
        }
    }
    
    
}
