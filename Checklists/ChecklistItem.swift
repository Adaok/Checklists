//
//  ChecklistItem.swift
//  Checklists
//
//  Created by iem on 03/03/2016.
//  Copyright © 2016 loiodice. All rights reserved.
//

import Foundation

class ChecklistItem {
    
    var text: String
    var checked: Bool
    
    init(text: String, checked: Bool = false){
        self.text = text
        self.checked = checked
    }
    
    func toogleChecked() {
        self.checked = !self.checked
    }
}