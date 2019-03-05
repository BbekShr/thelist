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
        let controller = builderRoute(storyboardName: "ToDoList", storyboardId: "ToDoListId") as! ToDoListViewController
        return controller
    }
    
    func routeToAddItem() -> UIViewController {
        let controller = builderRoute(storyboardName: "ItemAddScreen", storyboardId: "AddItemId") as! AddItemViewController
        return controller
    }
    
    func routeToCompletedItem() -> UIViewController {
        let controller = builderRoute(storyboardName: "CompletedList", storyboardId: "CompletedListId") as! CompletedListViewController
        return controller
    }
    
    
}

extension AuthenticateRoute{
    // Build Route Functions
    private func builderRoute(storyboardName: String, storyboardId: String) -> UIViewController {
        let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
        let todoListController = storyBoard.instantiateViewController(withIdentifier: storyboardId)
        return todoListController
    }
}
