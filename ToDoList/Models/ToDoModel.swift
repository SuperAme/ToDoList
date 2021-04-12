//
//  ToDoModel.swift
//  ToDoList
//
//  Created by IDS Comercial on 12/04/21.
//

import Foundation
import RealmSwift

class ToDoModel: Object {
    @objc dynamic var toDo: String?
    @objc dynamic var check: Bool = false
}
