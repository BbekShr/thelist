//
//  UserModel.swift
//  The List
//
//  Created by IMCS2 on 3/3/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

struct User {
    var userEmail: String
    var password: String
    var userId: String?
    var name: String
    
    // Empty Intialization
    init(){
        userEmail = ""
        password = ""
        userId = ""
        name = ""
    }
    
    // Intialization for User Signup
    init(userEmail: String, userPassword: String, name: String){
        self.userEmail = userEmail
        self.password = userPassword
        self.name = name
    }
}
