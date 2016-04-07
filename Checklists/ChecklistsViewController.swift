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
    var list:Checklist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = list.name
        listNote = list.item
        // Do any additional setup after loading the view, typically from a nib.
        
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
        saveChecklistItems()
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
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        listNote.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
        saveChecklistItems()
    }
    
    func addItemViewControllerDidCancel(controller: AddItemTableViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItemViewController(controller: AddItemTableViewController, didFinishAddingItem item: ChecklistItem){
        listNote.append(item)
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
        saveChecklistItems()
    }
    
    func addItemViewController(controller: AddItemTableViewController, didFinishEditingItem item: ChecklistItem){
        let indexItemToReload = listNote.indexOf({ $0 === item})
        listNote[indexItemToReload!].text = item.text
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
        saveChecklistItems()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addItem" {
            let destination = segue.destinationViewController as! UINavigationController
            let finalDestination = destination.topViewController as! AddItemTableViewController
            finalDestination.delegate = self
        } else if segue.identifier == "EditItem" {
            let destination = segue.destinationViewController as! UINavigationController
            let finalDestination = destination.topViewController as! AddItemTableViewController
            if let cell = sender as? UITableViewCell{
                finalDestination.itemToEdit = listNote[(tableView.indexPathForCell(cell)?.item)!]
            }
            finalDestination.delegate = self
        }
    }
    
    func documentDirectory()->NSURL {
        var path:NSURL?
        do{
            path = try NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        } catch {
            print("Something wrong")
        }
        return path!
    }
    
    func dataFileURL()->NSURL {
        let file = NSURL.init(fileURLWithPath: "Checklists.plist", isDirectory: false, relativeToURL: documentDirectory())
        return file
    }
    
    func saveChecklistItems(){
        NSKeyedArchiver.archiveRootObject(listNote, toFile: dataFileURL().path!)
    }
    
    func loadChecklistItems(){
        if NSFileManager.defaultManager().fileExistsAtPath(dataFileURL().path!) == false {
            return
        }
        listNote = NSKeyedUnarchiver.unarchiveObjectWithFile(dataFileURL().path!) as! [ChecklistItem]
    }
    
    override func awakeFromNib() {
        loadChecklistItems()
    }
    
}