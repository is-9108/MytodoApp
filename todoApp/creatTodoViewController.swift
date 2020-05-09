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
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func creatTodo(_ sender: Any) {
        
        let groupName = groupNameTextField.text!
        let password = passwordTextField.text!
        
        var ref:DocumentReference? = nil
        ref = db.collection("TODOGroup").addDocument(data: [
            "gruopName" : groupName,
            "password" : password
        ]){err in
            if let err = err{
                print(err.localizedDescription)
            }else{
                print(ref?.documentID)
            }
        }
        
        let editTodoViewController = self.storyboard?.instantiateViewController(withIdentifier: "editTodoViewController")
        present(editTodoViewController!,animated: true,completion: nil)
   
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
