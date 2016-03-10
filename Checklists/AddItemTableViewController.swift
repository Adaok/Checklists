//
//  AddItemTableViewController.swift
//  Checklists
//
//  Created by iem on 10/03/2016.
//  Copyright © 2016 loiodice. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {

    @IBOutlet weak var mNameItem: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done(sender: AnyObject) {
        print(mNameItem.text)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    override func viewWillAppear(animated: Bool) {
        mNameItem.becomeFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        
        let beforeInput: NSString = textField.text!
        let afterInput: NSString = beforeInput.stringByReplacingCharactersInRange(range, withString: string)
        
        
            doneButton.enabled = afterInput.length > 0
        
        return true
    }
    
    var delegate:AddItemViewControllerDelegate?
}

protocol AddItemViewControllerDelegate{
    func addItemViewControllerDidCancel(controller: AddItemTableViewController)
    func addItemViewController(controller: AddItemTableViewController, didFinishAddingItem item: ChecklistItem)
}