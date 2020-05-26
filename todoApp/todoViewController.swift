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
import UserNotifications


class todoViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
        
    @IBOutlet weak var datePicker: UIDatePicker!
    
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
        }
        print("groupName: \(groupName)")
        inputTodo()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(datePicker.date)
        let date = DateFormatter()
        date.dateFormat = "MM/dd HH:mm"
        print("\(date.string(from: datePicker.date))")
    }
    @IBAction func addButton(_ sender: Any) {
        let title = titleTextField.text!
        let alertTime = datePicker.date
        let date = DateFormatter()
        date.dateFormat = "MM/dd HH:mm"
        let deadline = date.string(from: datePicker.date)

        
        let todoData = [
            "title" : title,
            "time" : deadline
        ]

        self.ref.child("\(groupName)").childByAutoId().setValue(todoData)
        inputTodo()
        setNotification(title: title, alertTime: alertTime)
        titleTextField.text = ""

       
    }
    
    func setNotification(title:String,alertTime:Date){
        print("title: \(title)")
        print("alertTime: \(alertTime)")
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "明日が\(title)の期限です！"
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let timer:Date = Calendar.current.date(byAdding: .day, value: -1, to: alertTime)!
        print(timer)
        let dateComponents = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: timer)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)


        let request = UNNotificationRequest(identifier: "\(group.self)", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) {(error) in
            print(error ?? "ローカル通知登録　OK")
        }
        center.getPendingNotificationRequests{(requests: [UNNotificationRequest]) in
            for request in requests {
                print("--------------")
                print(request)
                print("--------------")
            }
        }
    }
    
    func inputTodo(){
        self.ref.child("\(groupName)").observe(DataEventType.childAdded,with:{ (snapshot) -> Void in
            let todoData = snapshot.value as? [String : AnyObject] ?? [:]
            print("todoData: \(todoData)")
            
            if let title = todoData["title"] as? String,let alertTime = todoData["alertTime"] as? String,let deadline = todoData["time"] as? String{
                print("title:\(title)")
                print("memo: \(alertTime)")
                print("user: \(deadline)")
            }
        })
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
