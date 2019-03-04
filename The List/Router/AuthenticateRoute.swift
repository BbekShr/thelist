//
//  AuthenticateRoute.swift
//  The List
//
//  Created by IMCS2 on 3/3/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//
import UIKit
import Foundation

class AuthenticateRoute {
    init(){
        
    }
    
    // Return ToDoListViewController to navigate to that controller
    func routeToMainScreen(userModel: User) -> UIViewController{
        let storyBoard = UIStoryboard(name: "ToDoList", bundle: nil)
        let todoListController = storyBoard.instantiateViewController(withIdentifier: "ToDoListId") as! ToDoListViewController
        return todoListController
    }
}
