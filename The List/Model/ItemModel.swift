//
//  ItemModel.swift
//  The List
//
//  Created by IMCS2 on 3/7/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import Foundation

struct ItemModel {
    var item: String
    var category: String
    var ownerId: String
    var friendId: [String]
    var isCompleted: Bool
    var dateAdded: String
    var dateReIssued: String
    var dateCompleted: String
    
    init(){
        item = ""
        category = ""
        ownerId = ""
        friendId = []
        isCompleted = false
        dateAdded = ""
        dateReIssued = ""
        dateCompleted = ""
    }
    
    init(item: String, category: String, ownerId: String, friendId: [String], isCompleted: Bool, dateAdded: String, dateReIssued: String, dateCompleted: String){
        self.init()
        self.item = item
        self.category = category
        self.friendId = friendId
        self.isCompleted = isCompleted
        self.dateAdded = dateAdded
        self.dateReIssued = dateReIssued
        self.dateCompleted = dateCompleted
    }
}
