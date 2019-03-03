//
//  UserAuthenticationViewModel.swift
//  The List
//
//  Created by IMCS2 on 3/3/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import Foundation
import Firebase

class UserAuthenticateViewModel {
    let user: User
    private var message: String // Output Error Message Code for custom Message Display
    
    init(user: User){
        self.user = user // Initialize the User Struct
        message = ""
    }
}

extension UserAuthenticateViewModel {
    
    // Sign up User
    func signUp(user: User, classRefernce: ViewController){
        Auth.auth().createUser(withEmail: user.userEmail, password: user.password) { (authData, error) in
            print("User is Inside Signup Process")
            if let errorObj: Error = error { // There is an error creating the account
                self.message = errorObj.localizedDescription
                classRefernce.displayError(errorMsg: self.message)
            }
            if let authObj = authData { // The signup successfully Completed
                print("Inside Success")
                print(authObj)
            }
        }
    }
    
}
