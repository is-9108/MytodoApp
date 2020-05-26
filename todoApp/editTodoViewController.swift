//
//  editTodoViewController.swift
//  todoApp
//
//  Created by Shota Ishii on 2020/05/08.
//  Copyright © 2020 is. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class editTodoViewController: UIViewController {
    
//getDocumentを使えば成功しそう？
    @IBOutlet weak var barItem: UINavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var groupName = ""
    
    var ref:DatabaseReference!
    
    var todoTitle = ""
    
    var todoMemo = ""
    
    var todoUser = ""
    
    var titleList:[String] = []
    
    var task:Task!
    
    var taskArray = try! Realm().objects(Task.self)

    override func loadView() {
        super.loadView()
        print("loadView")
        ref = Database.database().reference()
        inputTodo()
        tableView.reloadData()
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        tableView.delegate = self
        tableView.dataSource = self
        print("groupName: \(groupName)")
        print(titleList)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
     func inputTodo(){
        self.ref.child("\(groupName)").observe(DataEventType.childAdded,with:{ (snapshot) -> Void in
                let todoData = snapshot.value as? [String : AnyObject] ?? [:]
                print("todoData: \(todoData)")

                if let title = todoData["title"] as? String,let memo = todoData["memo"] as? String,let user = todoData["user"] as? String{
                    print("title:\(title)")
                    print("memo: \(memo)")
                    print("user: \(user)")

                    self.titleList.append(title)
                }
            })
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
      
    @IBAction func add(_ sender: Any) {

        let todoViewController = self.storyboard?.instantiateViewController(withIdentifier: "todoViewController") as! todoViewController
        todoViewController.groupName = groupName
        present(todoViewController,animated: true,completion: nil)
        
//        let alert = UIAlertController(title: "Title", message: "message", preferredStyle: .alert)
//        alert.addTextField(configurationHandler: {(textField:UITextField) -> Void in
//            textField.placeholder = "placeholder"
//        })
//
//        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {(action:UIAlertAction) -> Void in
//            let textField = alert.textFields! [0] as UITextField
//            //okボタンを押した時の処理
//
//            print("Text field: \((textField.text)!)")
//        }))
//        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: {(action:UIAlertAction) -> Void in
//            print("Text field: cancel")
//        }))
//        self.present(alert,animated: true,completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension editTodoViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
//            let title = titleList[indexPath.row]
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

extension editTodoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = titleList[indexPath.row]
        
        return cell
    }
    
    
}
