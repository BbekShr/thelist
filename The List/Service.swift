//
//  Service.swift
//  The List
//
//  Created by IMCS2 on 3/7/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

////////////////////////////////////////
// Write function and variables inside this class
// This class is intiated across the whole app
// Never Reinitated this class until and unless you want to create a new instance
////////////////////////////////////////

import Foundation
import Firebase

class Service {
    
    public var userModel: User
    public var taskArray: [ItemModel]
    public var completedTaskArray: [ItemModel]
    
    init(){
        userModel = User()
        taskArray = []
        completedTaskArray = []
    }
    
}

// All Public function Go Here
extension Service {
    // Get Today Date
    func getTodayDate() -> String{
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MMMM-dd-yyyy"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    func getErrorAlertHandler(errorMessage: String, buttonString: String) -> UIAlertController {
        let alert = UIAlertController(title: "Something Went Wrong!", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonString, style: .destructive, handler: nil))
        return alert
    }
}

// All Private function Go Here
extension Service {
    
}

let service = Service() // Class that is maintained throughout the app
