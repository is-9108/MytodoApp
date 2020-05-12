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
//        inputTodo()
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
        
        self.ref.childByAutoId().setValue(todoData)
        
        titleTextField.text = ""
        memoTextField.text = ""
        userNameTextField.text = ""
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        inputTodo()
    }
    
    func inputTodo(){
         print("開始")
         let ref:DatabaseReference? = nil
        self.ref.observe(DataEventType.childAdded, with: { (snapshot) -> Void in
             let postDict = snapshot.value as? [String : AnyObject] ?? [:]
             print(postDict)

             if let title = postDict["title"] as? String,let memo = postDict["memo"] as? String,let user = postDict["user"] as? String{
                 let editTodoViewController = self.storyboard?.instantiateViewController(withIdentifier: "editTodoViewController") as! editTodoViewController
                 editTodoViewController.todoTitle = title
                 editTodoViewController.todoMemo = memo
                 editTodoViewController.todoUser = user
                self.present(editTodoViewController,animated: true,completion: nil)
                 print("受け渡し完了")
             }
         })
     }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
