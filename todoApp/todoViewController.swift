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
      //  inputTodo()
        print("groupName: \(groupName)")
    }
    
    @IBAction func addButton(_ sender: Any) {
        let title = titleTextField.text!
        let memo = memoTextField.text!
        let user = userNameTextField.text!
        
//        let todoData = [
//            "title" : title,
//            "memo" : memo,
//            "user" : user
//        ]
        let key = ref.child("posts").childByAutoId().key
        let post = ["title": title,
                    "memo": memo,
                    "user": user]
        let childUpdates = ["/\(groupName)/\(String(describing: key))": post]
        ref.updateChildValues(childUpdates)
        
//        self.ref.child("\(groupName)").observeSingleEvent(of: .value, with: { (snapshot) in
//            for todo in snapshot.children{
//
//                if let snap = todo as? DataSnapshot{
//                    let td = snap.value! as! [String:String]
//                    print("title: \(td["title"]!)")
//                    try! self.realm.write{
//                        self.task.todoTitle = td["title"]!
//                        self.task.todoMemo = td["memo"]!
//                        self.task.todoUser = td["user"]!
//                        self.realm.add(self.task, update: .modified)
//                       // print("td task: \(self.task)")
//                    }
//                }
//            }
//
//        })
       
        
        titleTextField.text = ""
        memoTextField.text = ""
        userNameTextField.text = ""
       
    }
    
//    func inputTodo(){
//        self.ref.observe(DataEventType.childAdded, with: { (snapshot) -> Void in
//            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//            print(postDict)
//        })
//    }
    
//    func inputTodo(){
//         print("開始")
// //        let ref:DatabaseReference? = nil
//        self.ref.observe(DataEventType.childAdded, with: { (snapshot) -> Void in
//             let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//             print(postDict)
//
//             if let title = postDict["title"] as? String,let memo = postDict["memo"] as? String,let user = postDict["user"] as? String{
//                 let editTodoViewController = self.storyboard?.instantiateViewController(withIdentifier: "editTodoViewController") as! editTodoViewController
//                 editTodoViewController.todoTitle = title
//                 editTodoViewController.todoMemo = memo
//                 editTodoViewController.todoUser = user
//                self.present(editTodoViewController,animated: true,completion: nil)
//                 print("受け渡し完了")
//             }
//         })
//     }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
