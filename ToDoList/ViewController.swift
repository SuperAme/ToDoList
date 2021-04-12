//
//  ViewController.swift
//  ToDoList
//
//  Created by IDS Comercial on 08/04/21.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        view.backgroundColor = .white
        self.title = Constants.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDo))
        
    }
    
    @objc private func addToDo() {
        let newToDo = ToDoModel()
        let alert = UIAlertController(title: "Add To Do", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Add your To Do"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            newToDo.toDo = text
            self?.saveData(toDo: newToDo)
        }))
        present(alert, animated: true)
    }
    
    func saveData(toDo: ToDoModel) {
        do {
            try realm.write {
                realm.add(toDo)
            }
        } catch {
            print("error saving data \(error)")
        }
    }

}

