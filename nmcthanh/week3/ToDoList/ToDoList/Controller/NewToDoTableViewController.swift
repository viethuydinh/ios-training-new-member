//
//  NewToDoTableViewController.swift
//  ToDoList
//
//  Created by Thuy on 6/25/21.
//

import UIKit

class NewToDoTableViewController: UITableViewController {
    
    var sections = ["Basic Info", "Due Date", "Notes"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        switch indexPath.section {
        //        case 0:
        tableView.register(Cell1.self, forCellReuseIdentifier: "Cell1")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! Cell1
        return cell
        //        case 1:
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! UITableViewCell
        //            return cell
        //        default:
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3") as! UITableViewCell
        //            return cell
        //            }
    }
}
