//
//  creatTodoViewController.swift
//  todoApp
//
//  Created by Shota Ishii on 2020/05/08.
//  Copyright © 2020 is. All rights reserved.
//

import UIKit
import Firebase

class creatTodoViewController: UIViewController {

    @IBOutlet weak var groupNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var creatButton: UIButton!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    @IBAction func creatTodo(_ sender: Any) {
        
        let groupName = groupNameTextField.text!
        let password = passwordTextField.text!
        if groupNameTextField.text != "" && passwordTextField.text != ""{
        var ref:DocumentReference? = nil
        ref = db.collection("TODOGroup").addDocument(data: [
            "groupName" : groupName,
            "password" : password
        ]){err in
            if let err = err{
                print(err.localizedDescription)
            }
        }
        let editTodoViewController = self.storyboard?.instantiateViewController(withIdentifier: "editTodoViewController")
        present(editTodoViewController!,animated: true,completion: nil)
        }else{
            if groupNameTextField.text == ""{
                print("groupName")
                let alert: UIAlertController = UIAlertController(title: "グループ名を設定して下さい", message: nil, preferredStyle: .alert)
                
                let action:UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler:{
                    (action: UIAlertAction!) -> Void in
                    print("OK")
                })
                alert.addAction(action)
                self.present(alert,animated: true,completion: nil)
            }else if passwordTextField.text == ""{
                print("password")
                let alert: UIAlertController = UIAlertController(title: "パスワードを設定して下さい", message: nil, preferredStyle: .alert)
                
                let action:UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler:{
                    (action: UIAlertAction!) -> Void in
                    print("OK")
                })
                alert.addAction(action)
                self.present(alert,animated: true,completion: nil)
            }else{
                print("ALL")
                let alert: UIAlertController = UIAlertController(title: "グループ名とパスワードを設定して下さい", message: nil, preferredStyle: .alert)
                
                let action:UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler:{
                    (action: UIAlertAction!) -> Void in
                    print("OK")
                })
                alert.addAction(action)
                self.present(alert,animated: true,completion: nil)
            }
        }
           
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
