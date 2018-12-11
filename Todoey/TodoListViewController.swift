//
//  ViewController.swift
//  Todoey
//
//  Created by masato on 17/7/2018.
//  Copyright © 2018 masato. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon" ]


    // UserDefaults is database in iOS
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }

    // tableView numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Set ReUsable Cell 
        let cell = tableView.dequeueReusableCell(withIdentifier: " ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]

        return cell
    }


    //MARK - TableView Delegate Methods
    // when selected row, print the row number
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(itemArray[indexPath.row])


        // when choose cell, flash the hit cell
        tableView.deselectRow(at: indexPath, animated: true)

        // if check mark is set up, delete check mark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }


    }



    /*
     Add Button "+" Pressed
    */

    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: Any) {

        var textField = UITextField()


        // when Press "+" button pop up Alert Screen
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)


        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once user clikcs the Add Itme button on our UIAlert

            self.itemArray.append(textField.text!)


            // UserDefaulsへの書き込み
            // self is needed because of inside closure
            self.defaults.set(self.itemArray, forKey: "TodoListArray")



            // after input text in alertView, reroad table view
            // reloadData()がないと、入力がtableViewに反映されない
            self.tableView.reloadData()

    }

        // when write text to alert, (after closure),
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"

            textField = alertTextField
            print(alertTextField.text)
            print("now")
        }
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }

    /*
      End Add Button "+" Pressed
     */



}

