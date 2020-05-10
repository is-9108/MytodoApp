//
//  todoViewController.swift
//  todoApp
//
//  Created by Shota Ishii on 2020/05/08.
//  Copyright © 2020 is. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class todoViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var memoTextField: UITextView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    var ref:DatabaseReference!
    
    
    var groupName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    @IBAction func addButton(_ sender: Any) {
        let title = titleTextField.text!
        let memo = memoTextField.text
        let user = userNameTextField.text!
        
        let key = ref.child("\(groupName)").childByAutoId().key
        let post = [
            "title" : title,
            "memo" : memo,
            "user" : user
        ]
        
        let childUpdates = ["/posts/\(String(describing: key))": post]
        ref.updateChildValues(childUpdates)
        
        titleTextField.text = ""
        memoTextField.text = ""
        userNameTextField.text = ""
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
