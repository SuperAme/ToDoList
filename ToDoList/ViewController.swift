//
//  ViewController.swift
//  ToDoList
//
//  Created by IDS Comercial on 08/04/21.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = Constants.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDo))
        
    }
    
    @objc private func addToDo() {
        let alert = UIAlertController(title: "Add To Do", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Add your To Do"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
        }))
        present(alert, animated: true)
    }

}

