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
    var user: User
    private var message: String // Output Error Message Code for custom Message Display
    
    init(user: User){
        self.user = user // Initialize the User Struct
        message = ""
    }
}

// Signup User Extension Only
extension UserAuthenticateViewModel {
    
    // Sign up User
    func signUp(classRefernce: ViewController){
        Auth.auth().createUser(withEmail: user.userEmail, password: user.password) { (authData, error) in
            print("User is Inside Signup Process")
            if let errorObj: Error = error { // There is an error creating the account
                self.message = errorObj.localizedDescription
                classRefernce.displayError(errorMsg: self.message)
            }
            if let authObj = authData { // The signup successfully Completed
                self.user.userId = authObj.user.uid // Set the newly created User ID
                self.createUserEntry() // Creates the User profile in the database
                classRefernce.userSignupSuccess(userModel: self.user) // Call the callback function after success
            }
        }
    }
    
    // Creates a User Entry into the realtime database
    private func createUserEntry(){
        let databaseRef = DatabaseReferenceModel() // Referenece to Database Reference class
        let userNode = databaseRef.ref.child("Users").child(user.userId) // Particular User Node
        userNode.setValue([
            "FirstName": user.firstName,
            "LastName" : user.lastName,
            "Active" : true
            ]) // Create the json tree for account creation
    }

}
