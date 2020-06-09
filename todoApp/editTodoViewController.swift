//
//  editTodoViewController.swift
//  todoApp
//
//  Created by Shota Ishii on 2020/05/08.
//  Copyright © 2020 is. All rights reserved.
//

import UIKit
import Firebase
//import RealmSwift

class editTodoViewController: UIViewController {

    @IBOutlet weak var barItem: UINavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var groupName = ""
    
    var ref:DocumentReference? = nil
    
//    let realm = try! Realm()
//
//    var taskArray = try! Realm().objects(Task.self)
    
    var titleList:[String] = []
    var timeList:[String] = []
    var todoCount = 0

    override func loadView() {
        super.loadView()
        print("loadView")
//        ref = Database.database().reference()
//        inputTodo()
        doc()
        tableView.reloadData()
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        tableView.delegate = self
        tableView.dataSource = self
        print("groupName: \(groupName)")
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
//     func inputTodo(){
//        self.ref.child("\(groupName)").observe(DataEventType.childAdded,with:{ (snapshot) -> Void in
//                let todoData = snapshot.value as? [String : AnyObject] ?? [:]
//                print("todoData: \(todoData)")
//
//                if let title = todoData["title"] as? String,let alertTime = todoData["time"] as? String{
//                    print("title:\(title)")
//                    print("time: \(alertTime)")
//                    self.titleList.append(title)
//                    self.timeList.append(alertTime)
//                }
//            })
//    }
    
    func doc(){
        let db = Firestore.firestore()
        
        db.collection("\(groupName)").getDocuments(){ (QuerySnapshot,err) in
            if let err = err{
                print(err.localizedDescription)
            }else{
                for document in QuerySnapshot!.documents{
                    print("\(document.documentID) => \(document.data())")
                    self.titleList.append(document["title"] as! String)
                    self.timeList.append(document["time"] as! String)
                    print(time)
                    self.todoCount += 1
                }
            }
        }
    }
    

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.reloadData()
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let todoViewController:todoViewController = segue.destination as! todoViewController
//
//        if segue.identifier == "cellSegue"{
//            let indexPath = self.tableView.indexPathForSelectedRow
//            todoViewController.task = taskArray[indexPath!.row]
//            todoViewController.todoTitle = titleList[indexPath!.row]
//            todoViewController.todoTime = timeList[indexPath!.row]
//        }else{
//            let task = Task()
//            let allTask = realm.objects(Task.self)
//            if allTask.count != 0{
//                task.id = allTask.max(ofProperty: "id")! + 1
//            }
//            todoViewController.task = task
//            todoViewController.groupName = groupName
//        }
//    }
      
    @IBAction func add(_ sender: Any) {

        let todoViewController = self.storyboard?.instantiateViewController(withIdentifier: "todoViewController") as! todoViewController
        todoViewController.groupName = groupName

//        let task = Task()
//        let allTasks = realm.objects(Task.self)
//        if allTasks.count != 0{
//            task.id = allTasks.max(ofProperty: "id")! + 1
//        }
//        todoViewController.task = task

        present(todoViewController,animated: true,completion: nil)

    }
    
    @IBAction func back(_ sender: Any) {
        print(titleList)
        dismiss(animated: true, completion: nil)
    }
    
}

extension editTodoViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
//            try! realm.write{
//                self.realm.delete(self.titleList[indexPath.row])
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

extension editTodoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoCount
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let db = Firestore.firestore()
//
//        db.collection("\(groupName)").getDocuments(){ (QuerySnapshot,err) in
//            if let err = err{
//                print(err.localizedDescription)
//            }else{
//                for document in QuerySnapshot!.documents{
//                    print("\(document.documentID) => \(document.data())")
//                    let time = document["time"] as! String
//                    let title = document["title"] as! String
//                    self.titleList.append(document["title"] as! String)
//                    self.timeList.append(document["tile"] as! String)
//                    self.todoCount += 1
//                }
//            }
//        }
        cell.textLabel?.text = titleList[indexPath.row]
        cell.detailTextLabel?.text = timeList[indexPath.row]
        return cell
    }
    
    
}
