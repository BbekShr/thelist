//
//  UIHelper.swift
//  The List
//
//  Created by IMCS2 on 3/4/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Add a blurry effect to image
    func addBlurEffect(backgroundImage: UIImageView){
        let darkBlur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        let imageFrame = backgroundImage.bounds // Background Image Frame
        blurView.frame = CGRect(x: 0.0, y: 0.0, width: imageFrame.width, height: imageFrame.height + 100.0)
        backgroundImage.addSubview(blurView)
    }
    
    // Hide Navigation Bar
    func hideNavigationBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func showNavigationBar(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // Add a Background Image to the view Screen
    func addBackgroundImage(){
        let imageView = UIImageView(image: UIImage(named: "loginBackground")) // Image View Holder
        imageView.frame = view.bounds // Image Size
        view.insertSubview(imageView, at: 0) // Insert at the lower stack of image
        addBlurEffect(backgroundImage: imageView)
    }
}
