//
//  CheckedListItem.swift
//  Checklists
//
//  Created by Yulin Feng on 10/7/17.
//  Copyright © 2017 Yulin730. All rights reserved.
//

import Foundation

class CheckListItem: NSObject{
    var text = ""
    var isChecked = false
    
    func toggleChecked(){
        isChecked = !isChecked
    }
}
