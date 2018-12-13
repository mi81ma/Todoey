//
//  ViewController.swift
//  Todoey
//
//  Created by masato on 17/7/2018.
//  Copyright © 2018 masato. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")



    override func viewDidLoad() {
        super.viewDidLoad()


        print(dataFilePath)

        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)

        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)

        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)

       


        // Do any additional setup after loading the view, typically from a nib.

//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }

        

    }

    // tableView numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return itemArray.count

    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

// Set ReUsable Cell
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")

        let cell = tableView.dequeueReusableCell(withIdentifier: " ToDoItemCell", for: indexPath)


        let item = itemArray[indexPath.row]

        cell.textLabel?.text = item.title


        cell.accessoryType = item.done ? .checkmark : .none

//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
//
        return cell
    }


    //MARK - TableView Delegate Methods
    // when selected row, print the row number

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//        print(itemArray[indexPath.row])


        // Checkmark is written into oposit True or False
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        saveItems()


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

            let newItem = Item()
            newItem.title = textField.text!

            self.itemArray.append(newItem)

            self.saveItems()

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


    //MARK - Model Manupulation Methods
    func saveItems() {
        let encoder = PropertyListEncoder()

        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding array, \(error)")
        }

        self.tableView.reloadData()
    }


}

