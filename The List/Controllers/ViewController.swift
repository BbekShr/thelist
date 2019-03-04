//
//  ViewController.swift
//  The List
//
//  Created by Pandu on 2/27/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var userAuthenticate: UserAuthenticateViewModel?
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorMessageText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userAuthenticate = UserAuthenticateViewModel()
    }
    
    @IBAction func signInAction(_ sender: Any) {
        let email: String = emailText.text!
        let password: String = passwordText.text!
        
        userAuthenticate?.login(classReference: self, email: email, password: password)
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "SignUp", bundle: nil) // Storyboard Reference
        let signUpController = storyBoard.instantiateViewController(withIdentifier: "SignUpId") as! SignUpViewController
        self.present(signUpController, animated: true, completion: nil)
    }

}

// Call Back Functions for View Model
extension ViewController {
    // Display Error when there is error in authentication
    public func displayError(errorMsg: String){
        errorMessageText.text = errorMsg // Set error message in the screen
        emailText.text = "" // Clear Email Text
        passwordText.text = "" // Clear Password Text
    }
    
    public func userSigninSuccess(userModel: User){
        errorMessageText.text = "" // Clear the error message
    }
}

