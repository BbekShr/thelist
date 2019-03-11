//
//  FriendsViewController.swift
//  The List
//
//  Created by Bibek Shrestha on 3/5/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    
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
    
    private func itemAddSuccess(){
        self.dismiss(animated: true) { // Notify when the modal dissmiss with successful add
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addItemIsDismissed"), object: nil)
        }
    }
    
    private func displayError(errorMessage: String){
        let alert = service.getErrorAlertHandler(errorMessage: errorMessage, buttonString: "Continue")
        self.present(alert, animated: true)
    }
    
    @IBAction func addFriendAction(_ sender: Any) {
        
        var email: String = ""
        let alert = UIAlertController(title: "Add Friend", message: "Please enter a email address below", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input email here..."
        })
        
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            email = (alert.textFields?.first?.text)!
            print(email)
            self.itemAddViewModel.addFriend(friendEmail: email, successHandler: {

                self.itemAddSuccess()
            }, errorHandler: {(errorMessage) in
                self.displayError(errorMessage: errorMessage)
            })
            
        }))
        
        self.present(alert, animated: true)
        
    }
    
    
    
}



