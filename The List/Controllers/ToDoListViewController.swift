//
//  ToDoListViewController.swift
//  The List
//
//  Created by IMCS2 on 3/3/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    private var route: AuthenticateRoute = AuthenticateRoute()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage() // Added Background Image
        showNavigationBar()
        
        // Do any additional setup after loading the view.
    }
 
}

extension ToDoListViewController{
    @IBAction func addListAction(_ sender: Any) {
        var controller = route.routeToAddItem()
        self.navigationController?.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func completedListAction(_ sender: Any) {
        var controller = route.routeToCompletedItem()
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    
    
    
}
