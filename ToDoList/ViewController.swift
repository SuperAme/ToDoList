//
//  ViewController.swift
//  ToDoList
//
//  Created by IDS Comercial on 08/04/21.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let realm = try! Realm()
    var toDoList: Results<ToDoModel>?
    var myarray = ["hola", "mundo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        view.addSubview(tableView)
        view.backgroundColor = .white
        self.title = Constants.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDo))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
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
    
    func loadData() {
        toDoList = realm.objects(ToDoModel.self)
        tableView.reloadData()
    }
    
    func saveData(toDo: ToDoModel) {
        do {
            try realm.write {
                realm.add(toDo)
            }
        } catch {
            print("error saving data \(error)")
        }
        tableView.reloadData()
    }

}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let toDoCheck = toDoList?[indexPath.row] {
            cell.textLabel?.text = toDoList?[indexPath.row].toDo
            cell.accessoryType = toDoCheck.check ? .checkmark : .none
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let toDoCheck = toDoList?[indexPath.row] {
            do {
                try realm.write {
                    toDoCheck.check = !toDoCheck.check
                }
            } catch {
                print("error Saving Data \(error)")
            }
        }
        tableView.reloadData()
    }
}

