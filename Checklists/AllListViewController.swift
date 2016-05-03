//
//  AllListViewController.swift
//  Checklists
//
//  Created by iem on 07/04/2016.
//  Copyright © 2016 loiodice. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController, AddListViewControllerDelegate {
    
    var listChecklists = [Checklist]()
    var items = [ChecklistItem]()
    var currentList:Checklist?
    
    override func viewDidLoad() {

        var itemOne:ChecklistItem = ChecklistItem(text: "Toto")
        var itemTwo:ChecklistItem = ChecklistItem(text: "Titi", checked: true)
        var itemThree:ChecklistItem = ChecklistItem(text: "Tutu")
        
        items.append(itemOne)
        items.append(itemTwo)
        items.append(itemThree)
        
        var one:Checklist = Checklist(name: "Liste 1")
        var two:Checklist = Checklist(name: "Liste 2")
        var three:Checklist = Checklist(name: "Liste 3", item: items)
        
        listChecklists.append(one)
        listChecklists.append(two)
        listChecklists.append(three)
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int{
        return listChecklists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath: NSIndexPath) ->UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("ListItem", forIndexPath: cellForRowAtIndexPath)
        configureTextForCell(cell, withItem: listChecklists[cellForRowAtIndexPath.row])
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        currentList = listChecklists[indexPath.row]
        tableView.reloadData()
    }
    
    func configureTextForCell(cell : UITableViewCell, withItem item:Checklist){
        if let label = cell.viewWithTag(1) as? UILabel {
            label.text = item.name
        }
    }
    
    func addListViewControllerDidCancel(controller: ListDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addListViewController(controller: ListDetailViewController, didFinishEditingList list: Checklist) {
        let indexListToReload = listChecklists.indexOf({$0 === list})
        listChecklists[indexListToReload!].name = list.name
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func addListViewController(controller: ListDetailViewController, didFinishAddingList list: Checklist) {
        listChecklists.append(list)
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SelectList" {
            let destination = segue.destinationViewController as! ChecklistsViewController
            destination.list = listChecklists[tableView.indexPathForSelectedRow!.row]
        } else if segue.identifier == "AddList" {
            let destination = segue.destinationViewController as! UINavigationController
            let finalDestination = destination.topViewController as! ListDetailViewController
            finalDestination.delegate = self
        } else if segue.identifier == "EditList" {
            let destination = segue.destinationViewController as! UINavigationController
            let finalDestination = destination.topViewController as! ListDetailViewController
            if let cell = sender as? UITableViewCell{
                finalDestination.listToEdit = listChecklists[(tableView.indexPathForCell(cell)?.item)!]
            }
            finalDestination.delegate = self
        }
    }
}