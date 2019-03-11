//
//  ItemAddViewModel.swift
//  The List
//
//  Created by IMCS2 on 3/7/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import Firebase

class ItemAddViewModel{
    private var itemModel: ItemModel
    private var errorMsg: String = ""
    private var databaseRef: DatabaseReferenceModel // Database Reference Object
    private var userNode: DatabaseReference // Reference to the user node
    
    init(){
        itemModel = ItemModel()
        databaseRef = DatabaseReferenceModel()
        self.userNode = databaseRef.ref.child("Users").child(service.userModel.userId) // Particular User Node here
    }
    
}

// All Public Class here
extension ItemAddViewModel {
    func addItem(item: String, category: String, friendEmail: String = "", successHandler: @escaping () -> Void, errorHandler: @escaping (_ error: String) -> Void) {
        if checkData(item: item, category: category, friendEmail: friendEmail) { // Check if Data passes the initial Process
            if !friendEmail.isEmpty && friendEmail != service.userModel.userEmail { // Need to Attach task to a friend too. Same Email as Friend Email will be treated as no friend
                checkFriendId(friendEmail: friendEmail, completionHandler: {(friendId) in // Friend ID Found
                    self.addFriendId(userId: service.userModel.userId, friendId: friendId, completionHandler: { // Friend ID is ready for use
                        self.readyCategoryForUse(userId: service.userModel.userId, category: category, completionHander: {() in // Category is ready for use
                            self.setItemModel(item: item, category: category, ownerId: service.userModel.userId, friendId: friendId, isCompleted: false, dateAdded: service.getTodayDate(), dateReIssued: "", dateCompleted: "") // Set Item Model for use
                            self.addItemToTask(itemModel: self.itemModel) // Item Added To Task Node
                            successHandler() // Function to Call When function runs successfully
                        })
                    })
                }, notFoundHandler: {(errorMessage) in errorHandler(errorMessage)})
            }else { // Make Task only for User
                self.readyCategoryForUse(userId: service.userModel.userId, category: category, completionHander: {() in // Category is ready for use
                    self.setItemModel(item: item, category: category, ownerId: service.userModel.userId, friendId: "", isCompleted: false, dateAdded: service.getTodayDate(), dateReIssued: "", dateCompleted: "") // Set Item Model for use
                    self.addItemToTask(itemModel: self.itemModel) // Item Added To Task Node
                    successHandler() // Function to Call When function runs successfully
                })
            }
        } else {errorHandler(errorMsg)}
    }
}

// All Private Class here
extension ItemAddViewModel {
    
    private func setItemModel(item: String, category: String, ownerId: String, friendId: String, isCompleted: Bool, dateAdded: String, dateReIssued: String, dateCompleted: String){
        itemModel.item = item
        itemModel.category = category
        itemModel.ownerId = ownerId
        itemModel.friendId = friendId
        itemModel.isCompleted = isCompleted
        itemModel.dateAdded = dateAdded
        itemModel.dateReIssued = dateReIssued
        itemModel.dateCompleted = dateCompleted
    }
    
    // This check the data for entry into the system
    // ErrorMsg is set here
    private func checkData(item: String, category: String, friendEmail: String = "") -> Bool{
        if !item.isEmpty && !category.isEmpty { // Check if item and catgory is filledup
            if !friendEmail.isEmpty{ // Check if the friendEmail is valid
                if friendEmail.isValidEmail() { // Check if the email is valid format
                    return true
                } else { errorMsg = "The format of the email is not correct" }
            }else {return true}
        }else{ errorMsg = "Please Fillup Item and Catgory field" }
        return false
    }
    
    // Add Item to the Task Node
    // BEWARE: All Data need to verified and ready to use before performing this
    private func addItemToTask(itemModel: ItemModel){
        let referenece = self.databaseRef.ref.child("Tasks").childByAutoId() // Reference to the Node
        referenece.setValue([
            "Name" : itemModel.item,
            "Category" : itemModel.category,
            "OwnerId" : itemModel.ownerId,
            "FriendId" : itemModel.friendId,
            "DateAdded" : itemModel.dateAdded,
            "DateCompleted" : itemModel.dateCompleted,
            "DateReIssued" : itemModel.dateReIssued,
            "IsComplete" : itemModel.isCompleted
            ]) // Set Data to Firebase
        var newItem = itemModel
        newItem.itemId = referenece.key! // Get the node key for this task
       service.taskArray.insert(newItem, at: 0) // Put The Item Model into the Service Task Array
    }
    
}

// Extension for Friend ID
extension ItemAddViewModel {
    
    public func getFriendEmailList(userId: String, completionHandler: @escaping (_ friendEmailArray: [String]) -> Void){
        self.getFriendIdList(userId: userId) { (friendIdArray) in
            var friendEmailArray: [String] = []
            if !friendIdArray.isEmpty { // Only Call if friendIdArray is not Empty
                let db = self.databaseRef.ref.child("Users")
                for userId in friendIdArray {
                    db.child(userId).observeSingleEvent(of: .value, with: { (allUserSnapshot) in
                        let userDictonary = allUserSnapshot.value as! NSDictionary
                        let friendEmail = userDictonary.value(forKey: "Email") as! String
                        friendEmailArray.append(friendEmail) // List of Friend Email
                        completionHandler(friendEmailArray) // Code To Call when we finalize the friend Email Array
                    })
                }
            }else {
                completionHandler(friendEmailArray) // Code to call when we get the email Array
            }
        }
    }
    
    public func getFriendIdList(userId: String, completionHandler: @escaping (_ friendIdArray: [String]) -> Void){
        self.databaseRef.ref.child("Users").child(userId).child("FriendList").observeSingleEvent(of: .value) { (dataSnapshot) in
            var friendArray: [String] = []
            if dataSnapshot.exists() {
                friendArray = (dataSnapshot.value as! NSArray) as! [String]
            }
            completionHandler(friendArray) // Code to Run when got all the list
        }
    }
    
    // Check if Friend email is ready to use or not.
    // Completion Handler if we get the friend ID
    private func checkFriendId(friendEmail: String, completionHandler: @escaping (_ friendId: String) -> Void, notFoundHandler: @escaping (_ error: String) -> Void){
        Auth.auth().fetchProviders(forEmail: friendEmail) { (providers, error) in
            if providers != nil { // The user is registered with the system
                self.databaseRef.ref.child("Users").observeSingleEvent(of: .value, with: { (allUserSnapshot) in
                    var friendId = "" // Get Friend ID
                    for userSnapshot in allUserSnapshot.children {
                        let userDataSnapShot = userSnapshot as! DataSnapshot
                        let userSnapshotDictonary = userDataSnapShot.value as! NSDictionary
                        if friendEmail == userSnapshotDictonary.value(forKey: "Email") as! String { // Found the node of the friend user
                            friendId = userDataSnapShot.key
                            break
                        }
                    }
                    if !friendId.isEmpty { // The ID is found with that email
                        completionHandler(friendId) // Code after we get the ID of the Friend
                    }else {notFoundHandler("Something is Wrong with this User Email. Sorry! Cannot be added")} // User Database is Corrupted
                })
            }else {
                notFoundHandler("No User with that Email address has been found") // Not Found Handler
            }
        }
    }
    
    private func addFriendId(userId: String, friendId: String, completionHandler: @escaping () -> Void){
        isFriendAdded(userId: userId, friendId: friendId, existHandler: { (friendArray) in // Friend ID Exist in the array
            completionHandler() // Code after Friend ID is found in User Array
        }, notExistHandler: {(friendArray) in // Friend ID Dont exist in the array
            var friendList = friendArray
            friendList.append(friendId)
            self.databaseRef.ref.child("Users").child(userId).child("FriendList").setValue(friendList) // Update the entire array in the list
            completionHandler() // Code after Friend ID is found in User Array
        })
    }
    
    // Check if Friend ID Exist in the particular user
    private func isFriendAdded(userId: String, friendId: String, existHandler: @escaping (_ friendArray: [String]) -> Void ,  notExistHandler: @escaping (_ friendArray: [String]) -> Void){
        self.databaseRef.ref.child("Users").child(userId).child("FriendList").observeSingleEvent(of: .value, with: { (dataSnapshot) in
            if dataSnapshot.exists() { // The Friend List array for this user exist
                let friendList = dataSnapshot.value as! NSArray
                if friendList.contains(friendId) { // Friend ID Exist
                    existHandler(friendList as! [String]) //Codes to call after we get the friendId
                } else{notExistHandler(friendList as! [String])} // Code to call after we dont fint the friendID
            }else{notExistHandler([])}
        })
    }
}

// Extension For Category
extension ItemAddViewModel {
    
    public func getCategoryList(userId: String, completionHandler: @escaping (_ categoryArray: [String]) -> Void){
        self.databaseRef.ref.child("Users").child(userId).child("CategoryList").observeSingleEvent(of: .value) { (dataSnapshot) in
            var categoryArray: [String] = []
            if dataSnapshot.exists() {
                categoryArray = (dataSnapshot.value as! NSArray) as! [String]
            }
            completionHandler(categoryArray)
        }
    }
    
    // Ready Category for use
    // Completion Handler after we set the Category with the firebase
    private func readyCategoryForUse(userId: String, category: String, completionHander: @escaping () -> Void){
        isCategoryExist(userId: userId, category: category, existHandler: { (categoryArray) in // Category Exist
            completionHander() // Code After Category is ready to Use
        }, notExistHandler: {(categoryArray) in // Category Dont Exist
            var categories = categoryArray
            categories.append(category) // Add Category to the List
            self.databaseRef.ref.child("Users").child(userId).child("CategoryList").setValue(categories) // Add All The Category to Firebase for that User
            completionHander() // Code After category is ready to use
        })
    }
    
    // Check If Category exist in an userId
    private func isCategoryExist(userId: String, category: String, existHandler: @escaping (_ categoryArray: [String]) -> Void, notExistHandler: @escaping (_ categoryArray: [String]) -> Void){
        databaseRef.ref.child("Users").child(userId).child("CategoryList").observeSingleEvent(of: .value) { (dataSnapshot) in
            if dataSnapshot.exists() { // The Category Array is Present
                let categoryArray = dataSnapshot.value as! NSArray
                if categoryArray.contains(category) { // The Category is Present
                    existHandler(categoryArray as! [String]) // Function to call after category Exist
                }else{notExistHandler(categoryArray as! [String])}
            }else{notExistHandler([])}
        }
    }
}

extension ItemAddViewModel {
    
    private func checkFriendEmail(friendEmail: String = "") -> Bool{
        if !friendEmail.isEmpty{ // Check if the friendEmail is valid
            if friendEmail.isValidEmail() { // Check if the email is valid format
                return true
            } else { errorMsg = "The format of the email is not correct"}
        }
        return false
    }
    
    func addFriend(friendEmail: String = "", successHandler: @escaping () -> Void, errorHandler: @escaping (_ error: String) -> Void) {
        if checkFriendEmail(friendEmail: friendEmail) { // Check if Data passes the initial Process
            if !friendEmail.isEmpty && friendEmail != service.userModel.userEmail { // Need to Attach task to a friend too. Same Email as Friend Email will be treated as no friend
                checkFriendId(friendEmail: friendEmail, completionHandler: {(friendId) in // Friend ID Found
                    self.addFriendId(userId: service.userModel.userId, friendId: friendId, completionHandler: { })
                }, notFoundHandler: {(errorMessage) in errorHandler(errorMessage)})
            }else {errorHandler(errorMsg)}
    }
    
 
}


}
