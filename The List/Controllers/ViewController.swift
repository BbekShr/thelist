//
//  ViewController.swift
//  The List
//
//  Created by Pandu on 2/27/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userAuthenticate: UserAuthenticateViewModel?
    var route: AuthenticateRoute = AuthenticateRoute()
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorMessageText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addBackgroundImage()
        hideNavigationBar()
        userAuthenticate = UserAuthenticateViewModel()
        print("Signin intiated")
    }
    
    @IBAction func signInAction(_ sender: Any) {
        let email: String = emailText.text!
        let password: String = passwordText.text!
        startSpinner(viewObject: view) // Start loading View
        userAuthenticate?.login(classReference: self, email: email, password: password)
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "SignUp", bundle: nil) // Storyboard Reference
        let signUpController = storyBoard.instantiateViewController(withIdentifier: "SignUpId") as! SignUpViewController
        self.navigationController?.pushViewController(signUpController, animated: true)
    }

}

// Call Back Functions for View Model
extension ViewController {
    // Display Error when there is error in authentication
    public func displayError(errorMsg: String){
        removeSpinner() // Stop Loading Process
        errorMessageText.text = errorMsg // Set error message in the screen
        emailText.text = "" // Clear Email Text
        passwordText.text = "" // Clear Password Text
    }
    
    // Process when Signin is successfull
    public func userSigninSuccess(userModel: User){
        removeSpinner() // Stop Loading Process
        errorMessageText.text = "" // Clear the error message
        let controller = self.route.routeToMainScreen(userModel: userModel) // Router configuration completed and ready to route
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
