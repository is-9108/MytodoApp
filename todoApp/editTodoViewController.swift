//
//  editTodoViewController.swift
//  todoApp
//
//  Created by Shota Ishii on 2020/05/08.
//  Copyright © 2020 is. All rights reserved.
//

import UIKit
import Firebase

class editTodoViewController: UIViewController {
    

    @IBOutlet weak var barItem: UINavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var groupName = ""
       
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
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
    
}

extension editTodoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = ""
        return cell
    }
    
    
}
