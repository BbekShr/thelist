//
//  UIHelper.swift
//  The List
//
//  Created by IMCS2 on 3/4/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit

// Add a blurry effect to image
func addBlurEffect(backgroundImage: UIImageView){
    let darkBlur = UIBlurEffect(style: UIBlurEffect.Style.dark)
    let blurView = UIVisualEffectView(effect: darkBlur)
    blurView.frame = backgroundImage.bounds
    backgroundImage.addSubview(blurView)
}

