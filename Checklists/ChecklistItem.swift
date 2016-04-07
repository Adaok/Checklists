//
//  ChecklistItem.swift
//  Checklists
//
//  Created by iem on 03/03/2016.
//  Copyright © 2016 loiodice. All rights reserved.
//

import Foundation

class ChecklistItem :NSObject {
    
    var text: String
    var checked: Bool
    
    init(text: String, checked: Bool = false){
        self.text = text
        self.checked = checked
    }
    
    func toogleChecked() {
        self.checked = !self.checked
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let text = decoder.decodeObjectForKey("text") as? String
        else { return nil }
        
        self.init(
            text: text,
            checked: decoder.decodeBoolForKey("checked")
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.text, forKey: "text")
        coder.encodeBool(self.checked, forKey: "checked")
    }
}