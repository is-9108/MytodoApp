//
//  Task.swift
//  todoApp
//
//  Created by Shota Ishii on 2020/05/15.
//  Copyright © 2020 is. All rights reserved.
//

import Foundation
import RealmSwift
class Task:Object {
    
    @objc dynamic var id = 0
    
    @objc dynamic var todoTitle = ""
    
    @objc dynamic var todoMemo = ""
    
    @objc dynamic var todoUser = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
