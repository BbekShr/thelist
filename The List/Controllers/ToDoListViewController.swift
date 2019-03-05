//
//  ToDoListViewController.swift
//  The List
//
//  Created by IMCS2 on 3/3/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {

    @IBOutlet weak var imageBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBlurEffect(backgroundImage: imageBackground)
        showNavigationBar()
        // Do any additional setup after loading the view.
    }

}
