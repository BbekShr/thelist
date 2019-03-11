//
//  FriendsViewController.swift
//  The List
//
//  Created by Bibek Shrestha on 3/5/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    @IBAction func addFriendAction(_ sender: Any) {
        
    
        
    }
    
    @IBOutlet weak var friendTable: UITableView!
    var friendArray: [String] = []
    private var itemAddViewModel: ItemAddViewModel = ItemAddViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
        itemAddViewModel.getFriendEmailList(userId: service.userModel.userId) { (friendList) in
            self.friendArray = friendList
            self.friendTable.reloadData()
        }
    }
    
    

}

extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCellId", for: indexPath as IndexPath)
        cell.textLabel?.text = friendArray[indexPath.row]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    
    
    
}
