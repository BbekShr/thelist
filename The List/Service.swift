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
    
    init(){
        userModel = User()
        taskArray = []
    }
    
}

// All Public function Go Here
extension Service {
    // Get Today Date
    func getTodayDate() -> String{
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
}

// All Private function Go Here
extension Service {
    
}

var service = Service() // Class that is maintained throughout the app
