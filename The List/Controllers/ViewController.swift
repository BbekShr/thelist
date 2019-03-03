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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Display Error when there is error in authentication
    public func displayError(errorMsg: String){
        print(errorMsg)
    }

    // Call back when User Signup Success
    public func userSignupSuccess(userModel: User){
        print(userModel.lastName)
    }

}

