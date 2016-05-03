//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by iem on 03/05/2016.
//  Copyright © 2016 loiodice. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController {

    @IBOutlet weak var mNameListField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var listToEdit :Checklist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let list = listToEdit {
            mNameListField.text = list.name
            title = "Edit list"
        }
        doneButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        print(mNameListField.text)
        let listToSend:Checklist = Checklist(name: mNameListField.text!)
        if listToEdit != nil {
            listToEdit?.name = mNameListField.text!
            delegate?.addListViewController(self, didFinishEditingList: listToEdit!)
        }
        else {
            delegate?.addListViewController(self, didFinishAddingList: listToSend)
        }
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        delegate?.addListViewControllerDidCancel(self)
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    override func viewWillAppear(animated: Bool) {
        mNameListField.becomeFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        let beforeInput: NSString = textField.text!
        let afterInput: NSString = beforeInput.stringByReplacingCharactersInRange(range, withString: string)
        
        doneButton.enabled = afterInput.length > 0
        
        return true
    }
    
    var delegate:AddListViewControllerDelegate?

}
protocol AddListViewControllerDelegate{
    func addListViewControllerDidCancel(controller: ListDetailViewController)
    func addListViewController(controller: ListDetailViewController, didFinishAddingList list: Checklist)
    func addListViewController(controller: ListDetailViewController, didFinishEditingList list: Checklist)
}
