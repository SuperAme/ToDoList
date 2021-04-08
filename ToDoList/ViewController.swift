//
//  ViewController.swift
//  ToDoList
//
//  Created by IDS Comercial on 08/04/21.
//

import UIKit

class ViewController: UIViewController {

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = Constants.title
        self.navigationItem.rightBarButtonItem = addButton
    }


}

