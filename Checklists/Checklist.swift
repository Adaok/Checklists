//
//  Checklist.swift
//  Checklists
//
//  Created by iem on 07/04/2016.
//  Copyright © 2016 loiodice. All rights reserved.
//

import Foundation

class Checklist: NSObject {
    
    var name: String
    var item:[ChecklistItem]
    
    init(name: String, item:[ChecklistItem]=[]){
        self.name = name
        self.item = item
    }
    
    required convenience init?(coder decoder:NSCoder) {
        guard let name = decoder.decodeObjectForKey("name") as? String,
            let item = decoder.decodeObjectForKey("item") as? [ChecklistItem]
            else { return nil }
        
        self.init(
            name: name,
            item: item
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.item, forKey: "item")
    }

}