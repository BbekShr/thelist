//
//  UserModel.swift
//  The List
//
//  Created by IMCS2 on 3/3/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

struct User {
    var userEmail: String
    var userId: String
    var firstName: String
    var lastName: String
    var categoryList: [String]
    var friendList: [String]
    
    // Empty Intialization
    init(){
        userEmail = ""
        userId = ""
        firstName = ""
        lastName = ""
        categoryList = []
        friendList = []
    }
    
    // Intialization for User Signup
    init(userEmail: String, firstName: String, lastName: String){
        self.init() // Intializing all Default value first
        self.userEmail = userEmail
        self.firstName = firstName
        self.lastName = lastName
    }
}
