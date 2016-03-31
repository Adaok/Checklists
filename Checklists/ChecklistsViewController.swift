//
//  ViewController.swift
//  Checklists
//
//  Created by iem on 03/03/2016.
//  Copyright © 2016 loiodice. All rights reserved.
//

import UIKit

class ChecklistsViewController: UITableViewController, AddItemViewControllerDelegate {

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
        listNote[indexPath.row].toogleChecked()
        tableView.reloadData()
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, withItem item: ChecklistItem) {
        switch(item.checked){
        case true: cell.viewWithTag(1)?.hidden = false
        
        case false : cell.viewWithTag(1)?.hidden = true
            
        default : cell.viewWithTag(1)?.hidden = true
        }
    }
    
    func configureTextForCell(cell : UITableViewCell, withItem item:ChecklistItem){
        if let label = cell.viewWithTag(2) as? UILabel {
            label.text = item.text
        }
    }
    
    @IBAction func addDumyTodo(sender: UIBarButtonItem) {
        var addedItem :ChecklistItem = ChecklistItem(text: "Dummy")
        listNote.append(addedItem)
        let indexPath = NSIndexPath(forRow: listNote.count-1, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        listNote.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
    }
    
    func addItemViewControllerDidCancel(controller: AddItemTableViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItemViewController(controller: AddItemTableViewController, didFinishAddingItem item: ChecklistItem){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addItem" {
            let destination = segue.destinationViewController as! UINavigationController
            let finalDestination = destination.topViewController as! AddItemTableViewController
            finalDestination.delegate = self
        }
    }
    
}