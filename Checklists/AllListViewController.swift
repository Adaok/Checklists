//
//  AllListViewController.swift
//  Checklists
//
//  Created by iem on 07/04/2016.
//  Copyright © 2016 loiodice. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    
    var listChecklists = [ChecklistItem]()
    
    override func viewDidLoad() {
        var one:ChecklistItem = ChecklistItem(text: "Liste 1")
        var two:ChecklistItem = ChecklistItem(text: "Liste 2")
        var three:ChecklistItem = ChecklistItem(text: "Liste 3")
        //var two:String = "Liste 2"
        //var three:String = "Liste 3"
        
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
        tableView.reloadData()
    }
    
    func configureTextForCell(cell : UITableViewCell, withItem item:ChecklistItem){
        if let label = cell.viewWithTag(1) as? UILabel {
            label.text = item.text
        }
    }
    
}