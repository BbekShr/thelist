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
    var userModel: User
    private var message: String // Output Error Message Code for custom Message Display
    private var databaseRef: DatabaseReferenceModel // Database Reference Object
    
    init(){
        self.userModel = User() // Initialize the User Struct
        message = ""
        self.databaseRef = DatabaseReferenceModel() // Referenece to Database Reference class
    }
}

// Signup User Extension Only
extension UserAuthenticateViewModel {
    
    // Sign up User
    func signUp(classRefernce: SignUpViewController, email: String, password: String, firstname: String, lastname: String){
        userModel.userEmail = email
        userModel.password = password
        userModel.firstName = firstname
        userModel.lastName = lastname
        Auth.auth().createUser(withEmail: userModel.userEmail, password: userModel.password) { (authData, error) in
            print("User is Inside Signup Process")
            if let errorObj: Error = error { // There is an error creating the account
                self.message = errorObj.localizedDescription
                classRefernce.displayError(errorMsg: self.message)
            }
            if let authObj = authData { // The signup successfully Completed
                self.userModel.userId = authObj.user.uid // Set the newly created User ID
                self.createUserEntry() // Creates the User profile in the database
                classRefernce.userSignupSuccess(userModel: self.userModel) // Call the callback function after success
            }
        }
    }
    
    // Creates a User Entry into the realtime database
    private func createUserEntry(){
        let userNode = self.databaseRef.ref.child("Users").child(userModel.userId) // Particular User Node
        userNode.setValue([
            "FirstName": userModel.firstName,
            "LastName" : userModel.lastName,
            "Active" : true
            ]) // Create the json tree for account creation
    }
}


extension UserAuthenticateViewModel {
    // Login user with Authentication
    func login(classReference: ViewController, email: String, password: String){
        userModel.userEmail = email
        userModel.password = password
        Auth.auth().signIn(withEmail: userModel.userEmail, password: userModel.password) { (userResult, error) in
            print("User is Inside Signin Process")
            if let errorObj = error { // User failed to login
                classReference.displayError(errorMsg: errorObj.localizedDescription)
            }
            if let userObj = userResult { // User Successfully Signed in
                self.userModel.userId = userObj.user.uid // Get User ID from firebase
                self.databaseRef.ref.child("Users").child(self.userModel.userId).observeSingleEvent(of: .value) { (dataSnapshot) in // Retrieve User Data From Database
                    let value = dataSnapshot.value as? NSDictionary
                    let firstName = value?["FirstName"] as? String ?? ""
                    let lastName = value?["LastName"] as? String ?? ""
                    self.userModel.firstName = firstName
                    self.userModel.lastName = lastName
                    classReference.userSigninSuccess(userModel: self.userModel) // Call Back Function in View Controller
                }
            }
        }
    }
    
    // User Model Populate with firebase data
    private func populateUserModel(classReference: ViewController){
        
    }
}
