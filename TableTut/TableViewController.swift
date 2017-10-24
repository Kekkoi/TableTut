//
//  TableViewController.swift
//  TableTut
//
//  Created by Miklos Kekkoi on 10/11/17.
//  Copyright © 2017 Miklos Kekkoi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var notes = [String]()
    
    
    @IBAction func addNotes(_ sender: UIBarButtonItem) {
        addNotes()
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.leftBarButtonItem = self.editButtonItem

    }


    // MARK: - Table view data source

    //As we only need one section we return 1.
    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    //We do not know how many rows we will have but we know that it will be equal with the number of notes in the tableView.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return notes.count
    }

    //As we are not creating a custom cell we can degueue a default one and set its basic properties like the label to our notes array.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = notes[indexPath.row]

        return cell
    }
    
    func addNotes() {
        let alertCtr = UIAlertController(title: "Add a note", message: "Type your note", preferredStyle: .alert)
        // do not use .actionsheet instead of .alert as textfields can only be added to alert controllers
        alertCtr.addTextField { (textFld) in
            textFld.placeholder = "Type something"
        }
        let alertAct = UIAlertAction(title: "Add", style: .default) {(_) in
            if let note = alertCtr.textFields?.first?.text {
                // as we are in a closure and the notes array is defined outside but used inside the closure we have to state a .self before it
                self.notes.append(note)
                self.tableView.reloadData()
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertCtr.addAction(alertAct)
        alertCtr.addAction(cancel)
        present(alertCtr, animated: true)
    }

    func editNotes(index: IndexPath) {
        let alertCtr = UIAlertController(title: "Edit a note", message: "", preferredStyle: .alert)
        
        alertCtr.addTextField { (textFld) in
            textFld.placeholder = "Type something"
        }
        let alertAct = UIAlertAction(title: "Edit", style: .default) {(_) in
            if let note = alertCtr.textFields?.first?.text {
                // we will insert our new note at the indexPath of our previous note which will jump one position ahead and that is why we know which note to remove!
                self.notes.insert(note, at: index.row)
                self.notes.remove(at: index.row + 1)
                self.tableView.reloadData()
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertCtr.addAction(alertAct)
        alertCtr.addAction(cancel)
        present(alertCtr, animated: true)
    }

    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
            let deleteRow = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
                //This will delete the String from our array
                self.notes.remove(at: indexPath.row)
                //This deletes the row that the indexpath represents (that we swiped) with a .right animation
                tableView.deleteRows(at: [indexPath], with: .right)
            }
        
        let editRow = UITableViewRowAction(style: .destructive, title: "edit") { (action, indexPath) in
           self.editNotes(index: indexPath)
        }
        
        editRow.backgroundColor = UIColor.blue
        

            return [deleteRow, editRow]
        }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Notes"
    }
    

}




