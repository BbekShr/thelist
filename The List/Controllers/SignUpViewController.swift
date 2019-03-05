//
//  SignUpViewController.swift
//  The List
//
//  Created by IMCS2 on 3/3/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorMessageText: UILabel!
    
    private let route: AuthenticateRoute = AuthenticateRoute()
    
    private var userAuthenticateViewModel: UserAuthenticateViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage() // Background Image
        hideNavigationBar()  // Hide Navigation Bar
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        startSpinner(viewObject: view)
        let firstName: String = firstNameText.text!
        let lastName: String = lastNameText.text!
        let email: String = emailText.text!
        let password: String = passwordText.text!
        userAuthenticateViewModel = UserAuthenticateViewModel()
        userAuthenticateViewModel?.signUp(classRefernce: self, email: email, password: password, firstname: firstName, lastname: lastName) // User Signup Process
    }
    
    @IBAction func goBackLoginAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// UserAuthenticationViewModel Callback functions
extension SignUpViewController{
    // Display Error when there is error in authentication
    public func displayError(errorMsg: String){
        removeSpinner()
        errorMessageText.text = errorMsg // Set error message in the screen
    }
    
    // Process when Signup is successfull
    public func userSignupSuccess(userModel: User){
        removeSpinner()
        let controller = route.routeToMainScreen(userModel: userModel)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
