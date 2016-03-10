//
//  ViewController.swift
//  Checklists
//
//  Created by iem on 03/03/2016.
//  Copyright © 2016 loiodice. All rights reserved.
//

import UIKit

class ChecklistsViewController: UITableViewController {

    var listNote = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var one :ChecklistItem = ChecklistItem(text: "Toto")
        var two :ChecklistItem = ChecklistItem(text: "Titi", checked: true)
        
        listNote.append(one)
        listNote.append(two)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return listNote.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: cellForRowAtIndexPath)
        configureTextForCell(cell, withItem: listNote[cellForRowAtIndexPath.row])
        configureCheckmarkForCell(cell, withItem: listNote[cellForRowAtIndexPath.row])
        return cell
    }
    
    override func tableView(tableView : UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, withItem item: ChecklistItem) {
        switch(item.checked){
        case true: cell.accessoryType = .Checkmark
            
        case false : cell.accessoryType = .None
            
        default : cell.accessoryType = .None
        }
    }
    
    func configureTextForCell(cell : UITableViewCell, withItem item:ChecklistItem){
        cell.textLabel?.text = item.text
    }
    
    


}