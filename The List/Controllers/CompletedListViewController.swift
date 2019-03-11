//
//  CompletedListViewController.swift
//  The List
//
//  Created by Bibek Shrestha on 3/5/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit

class CompletedListViewController: UIViewController {

    @IBOutlet weak var completeItemTable: UITableView!
    
    private var itemShowViewModel: ItemShowViewModel = ItemShowViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
        self.title = "Completed List"
        let nibName = UINib(nibName: "ItemCellTableViewCell", bundle: nil)
        completeItemTable.register(nibName, forCellReuseIdentifier: "itemCellId")
    }
}

extension CompletedListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.completedTaskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCellId", for: indexPath as IndexPath) as! ItemCellTableViewCell
        cell.commonInit(itemModel: service.completedTaskArray[indexPath.row]) // Setup Data in the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleted = UIContextualAction(style: .normal, title: "Delete") { (action, view, nil) in
            self.itemShowViewModel.removeItemFromCompleteTask(itemIndex: indexPath.row)
            self.completeItemTable.reloadData()
        }
        deleted.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        return UISwipeActionsConfiguration(actions: [deleted])
    }
    
}
