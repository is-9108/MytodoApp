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
        
        Firestore.firestore().collection("TODOGroup").getDocuments{ (snaps,error) in
            if let error = error{
                print("ERROR: \(error.localizedDescription)")
            }else{
                guard let snaps = snaps else {return}
                for document in snaps.documents{
                    print(document.data())
                    
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
