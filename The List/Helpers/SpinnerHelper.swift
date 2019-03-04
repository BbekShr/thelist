//
//  SpinnerHelper.swift
//  The List
//
//  Created by IMCS2 on 3/4/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import Foundation
import UIKit

var vSpinner : UIView?

// Function to add spinner view
func startSpinner(viewObject: UIView){
    let spinnerElement = UIView.init(frame: viewObject.bounds)
    spinnerElement.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
    let ai = UIActivityIndicatorView.init(style: .whiteLarge)
    ai.startAnimating()
    ai.center = spinnerElement.center
    spinnerElement.addSubview(ai)
    viewObject.addSubview(spinnerElement)
    
    vSpinner = spinnerElement
}

// Function to remove spinner view
func removeSpinner(){
    vSpinner?.removeFromSuperview()
    vSpinner = nil
}
