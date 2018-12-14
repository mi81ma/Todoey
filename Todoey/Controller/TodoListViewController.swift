//
//  ViewController.swift
//  Todoey
//
//  Created by masato on 17/7/2018.
//  Copyright © 2018 masato. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext



    override func viewDidLoad() {
        super.viewDidLoad()


        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))


//        searchBar.delegate = self



        loadItems()


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

//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)


         itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        saveItems()

        // when choose cell, flash the hit cell
        tableView.deselectRow(at: indexPath, animated: true)

    }



    /*
     Add Button "+" Pressed
    */

    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()


        // when Press "+" button pop up Alert Screen
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)


        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once user clikcs the Add Itme button on our UIAlert


            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false

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


    //MARK: - Model Manupulation Methods
    func saveItems() {


        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }

        self.tableView.reloadData()
    }


    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {


        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }

        tableView.reloadData()
    }

}


//MARK: - Search bar method

extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let request : NSFetchRequest<Item> = Item.fetchRequest()

        request.predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)


       request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

       loadItems(with: request)

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}
