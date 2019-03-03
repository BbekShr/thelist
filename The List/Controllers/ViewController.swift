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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let user: User = User.init(userEmail: "bbek@gmail.com", userPassword: "admin123", name: "BBEK International")
        userAuthenticate = UserAuthenticateViewModel(user: user)
        userAuthenticate?.signUp(user: user, classRefernce: self) // Sign up Logic
    }
    
    public func displayError(errorMsg: String){
        print("I am inside")
        print(errorMsg)
    }


}

