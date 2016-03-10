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
        cell.textLabel!.text = listNote[cellForRowAtIndexPath.row].text
        return cell
    }
    
    override func tableView(tableView : UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


}