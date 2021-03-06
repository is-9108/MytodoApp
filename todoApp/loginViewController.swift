//
//  loginViewController.swift
//  todoApp
//
//  Created by Shota Ishii on 2020/05/08.
//  Copyright © 2020 is. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class loginViewController: UIViewController {
    
    @IBOutlet weak var groupNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var newGroup: UIButton!
    
    
    let db = Firestore.firestore()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser == nil{
            let signInViewController = self.storyboard?.instantiateViewController(withIdentifier: "signInViewController")
            present(signInViewController!,animated: true,completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        let groupName = groupNameTextField.text!
        let password = passwordTextField.text!
        
        
        
        db.collection("TODOGroup").getDocuments(){ (QuerySnapshot, err) in
            if let err = err{
                print("ERROR: \(err.localizedDescription)")
            }else{
                for document in QuerySnapshot!.documents{
                    let todoGroup = document.data()
                    let group = todoGroup["groupName"] as! String
                    let pass = todoGroup["password"] as! String
                    print(group)
                    print(groupName)
                    print(pass)
                    print(password)
                    
                    if groupName == group{
                        if password == pass{
                            let editTodoViewController = self.storyboard?.instantiateViewController(withIdentifier: "editTodoViewController") as! editTodoViewController
                            editTodoViewController.groupName = group
                            self.present(editTodoViewController,animated: true,completion: nil)
                        }
                    }
                    
                }
            }
            
        }

    }
    
    @IBAction func newGroupButton(_ sender: Any) {
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
