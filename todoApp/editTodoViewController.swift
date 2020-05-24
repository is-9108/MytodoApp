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
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue", sender: nil)
    }
}

extension editTodoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = taskArray[indexPath.row]
        cell.textLabel?.text = task.todoTitle
        
        return cell
    }
    
    
}
