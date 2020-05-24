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
    
    var taskArray = try! Realm().objects(Task.self)
    
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
        self.ref.child("\(groupName)").observe(DataEventType.childAdded,with:{ (snapshot) -> Void in
            let todoData = snapshot.value as? [String : AnyObject] ?? [:]
            print("todoData: \(todoData)")
            
            if let title = todoData["title"] as? String,let memo = todoData["memo"] as? String,let user = todoData["user"] as? String{
                print("title:\(title)")
                print("memo: \(memo)")
                print("user: \(user)")
                
                let task = Task()
                let allTasks = self.realm.objects(Task.self)
                if allTasks.count != 0{
                    task.id = allTasks.max(ofProperty: "id")! + 1
                }
                try! self.realm.write{
                    self.task.todoTitle = title
                    self.task.todoMemo = memo
                    self.task.todoUser = user
                    self.realm.add(self.task.self, update: .modified)
                }
            }
        })
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
