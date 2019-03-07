//
//  ItemAddViewModel.swift
//  The List
//
//  Created by IMCS2 on 3/7/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

class ItemAddViewModel{
    private var itemModel: ItemModel
    private var errorMsg: String = ""
    
    init(){
        itemModel = ItemModel()
    }
    
}

// All Public Class here
extension ItemAddViewModel {
    func addItem(classReference: ViewController, item: String, category: String, friendEmail: String = "") {
        if checkData(item: item, category: category, friendEmail: friendEmail) { // Check if Data passes the initial Process
            
        }
        // ToDo: Call Error Function Reference here
    }
}

// All Private Class here
extension ItemAddViewModel {
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
}
