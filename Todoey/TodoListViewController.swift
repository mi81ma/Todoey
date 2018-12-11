//
//  ViewController.swift
//  Todoey
//
//  Created by masato on 17/7/2018.
//  Copyright © 2018 masato. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon" ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

    }




}

