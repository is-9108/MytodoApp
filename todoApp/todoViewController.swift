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
import RealmSwift


class todoViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var memoTextField: UITextView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    var ref:DatabaseReference!
    
    var task:Task!
    
    let realm = try! Realm()
    
    var groupName = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        if task != nil{
            titleTextField.text = task.todoTitle
            memoTextField.text = task.todoMemo
            userNameTextField.text = task.todoUser
        }
        print("groupName: \(groupName)")
        inputTodo()
    }
    
    @IBAction func addButton(_ sender: Any) {
        let title = titleTextField.text!
        let memo = memoTextField.text!
        let user = userNameTextField.text!
        
        let todoData = [
            "title" : title,
            "memo" : memo,
            "user" : user
        ]

        self.ref.child("\(groupName)").childByAutoId().setValue(todoData)
        inputTodo()
        
            
        titleTextField.text = ""
        memoTextField.text = ""
        userNameTextField.text = ""
       
    }
    
    func inputTodo(){
        self.ref.child("\(groupName)").observeSingleEvent(of: .value, with: { (snapshot) in
            let snap = snapshot.value as! [String : AnyObject]
            print("snap: \(snap.values)")
        })
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
