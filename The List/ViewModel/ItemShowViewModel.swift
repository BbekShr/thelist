//
//  ItemShowViewModel.swift
//  The List
//
//  Created by IMCS2 on 3/9/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import Foundation
import Firebase

class ItemShowViewModel {
    
    private var databaseRef: DatabaseReferenceModel = DatabaseReferenceModel()
    
    init(){
        
    }
    
    // This updates the service taskArray and taskCompletedArray directly
    func getAllItemFromServer(userId: String, completionHandler: @escaping () -> Void ){
        databaseRef.ref.child("Tasks").observeSingleEvent(of: .value) { (tasksSnapShot) in
            for taskSnapShot in tasksSnapShot.children {
                let taskDataSnapShot = taskSnapShot as! DataSnapshot
                let task = taskDataSnapShot.value as! NSDictionary // Particular Task Node
                if (task.value(forKey: "OwnerId") as! String == userId) || (task.value(forKey: "FriendId") as! String == userId) { // Check if this task is related to this User
                    let itemModel: ItemModel = self.setItemModel(itemObject: task)
                    if task.value(forKey: "IsComplete") as! Bool { // Task is Completed
                        service.completedTaskArray.insert(itemModel, at: 0) // Insert at Top
                    } else { // Task is not Completed
                        service.taskArray.insert(itemModel, at: 0) // Insert at TaskToDo Array
                    }
                }
            }
            completionHandler() // Call The Code that needs to be called after this
        }
    }
}

// Private Func Goes Here
extension ItemShowViewModel {
    
    // Creates the Item Model Data Struct
    private func setItemModel(itemObject: NSDictionary) -> ItemModel {
        let itemModel: ItemModel = ItemModel(
            item: itemObject.value(forKey: "Name") as! String,
            category: itemObject.value(forKey: "Category") as! String,
            ownerId: itemObject.value(forKey: "OwnerId") as! String,
            friendId: itemObject.value(forKey: "FriendId") as! String,
            isCompleted: itemObject.value(forKey: "IsComplete") as! Bool,
            dateAdded: itemObject.value(forKey: "DateAdded") as! String,
            dateReIssued: itemObject.value(forKey: "DateReIssued") as! String,
            dateCompleted: itemObject.value(forKey: "DateCompleted") as! String
        )
        return itemModel
    }
}