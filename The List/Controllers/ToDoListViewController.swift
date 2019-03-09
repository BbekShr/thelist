//
//  ToDoListViewController.swift
//  The List
//
//  Created by IMCS2 on 3/3/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var todoItemTable: UITableView!
    
    private var route: AuthenticateRoute = AuthenticateRoute()
    private var itemShowViewModel: ItemShowViewModel = ItemShowViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage() // Added Background Image
        showNavigationBar()
        NotificationCenter.default.addObserver(self, selector: #selector(ToDoListViewController.handleAddItemDismiss), name: NSNotification.Name(rawValue: "addItemIsDismissed"), object: nil)
        let nibName = UINib(nibName: "ItemCellTableViewCell", bundle: nil)
        todoItemTable.register(nibName, forCellReuseIdentifier: "itemCellId")
        itemShowViewModel.getAllItemFromServer(userId: service.userModel.userId, completionHandler: {() in // Service TaskArray and CompletedTaskArray has been updated
            self.todoItemTable.reloadData()
        })
        // Do any additional setup after loading the view.
    }
    
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCellId", for: indexPath as IndexPath) as! ItemCellTableViewCell
        cell.commonInit(itemModel: service.taskArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 142
    }
}

extension ToDoListViewController {
    
    @objc func handleAddItemDismiss() {
        todoItemTable.reloadData()
    }
    
    @IBAction func addListAction(_ sender: Any) {
        var controller = route.routeToAddItem()
        self.navigationController?.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func completedListAction(_ sender: Any) {
        var controller = route.routeToCompletedItem()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    
    
}
