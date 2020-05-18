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
    

    
    let realm = try! Realm()
    
    var task:Task!
    
    var taskArray = try! Realm().objects(Task.self)
       
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        ref = Database.database().reference()
        tableView.reloadData()
        print(taskArray)
        print("groupName: \(groupName)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(taskArray)
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(taskArray)
        tableView.reloadData()
    }
    
//    func inputTodo(){
//        self.ref.child("\(groupName)").observeSingleEvent(of: .value, with: { (snapshot) in
//          // Get user value
//            let title = snapshot.value!["title"] as! String
//            let memo = snapshot.value!["memo"] as! String
//            let user = snapshot.value!["user"] as! String
//            
//            try! self.realm.write{
//                
//            }
//
//          // ...
//          }) { (error) in
//            print(error.localizedDescription)
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let todo = segue.destination as! todoViewController
        
        if segue.identifier == "cellSegue"{
            let indexPath = self.tableView.indexPathForSelectedRow
            todo.task = taskArray[indexPath!.row]
        }//else{
//            let task = Task()
//
//            let allTasks = realm.objects(Task.self)
//            if allTasks.count != 0{
//                task.id = allTasks.max(ofProperty: "id")! + 1
//            }
//            todo.task = task
//        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
      
    @IBAction func add(_ sender: Any) {
        let task = Task()
        
        let allTasks = realm.objects(Task.self)
        if allTasks.count != 0{
            task.id = allTasks.max(ofProperty: "id")! + 1
        }
        let todoViewController = self.storyboard?.instantiateViewController(withIdentifier: "todoViewController") as! todoViewController
        todoViewController.groupName = groupName
        todoViewController.task = task
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
            try! realm.delete(self.taskArray[indexPath.row])
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
        print("title\(task.todoTitle)")
        return cell
    }
    
    
}
