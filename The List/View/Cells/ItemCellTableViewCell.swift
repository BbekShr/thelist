//
//  ItemCellTableViewCell.swift
//  The List
//
//  Created by IMCS2 on 3/9/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit

class ItemCellTableViewCell: UITableViewCell {

    @IBOutlet weak var itemText: UILabel!
    @IBOutlet weak var categoryText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var friendText: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var friendLabel: UILabel!
    
    private var itemShowViewModel: ItemShowViewModel = ItemShowViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInit(itemModel: ItemModel){
        itemText.text = itemModel.item
        categoryText.text = itemModel.category
        friendSectorHandling(itemModel: itemModel) // Handles the friend sector
        dateSectorHandling(itemModel: itemModel) // Handles the date sector
    }
    
    // Handles the friend sector and all the logic
    private func friendSectorHandling(itemModel: ItemModel){
        friendLabel.text = "Assigned To: "
        if !itemModel.friendId.isEmpty { // Friend is assigned
            var userId = itemModel.friendId // Id of the friend
            if userId == service.userModel.userId { // Current User is assigned to this task
                friendLabel.text = "Added By:"
                userId = itemModel.ownerId // get the id of the user that assigned this task to current user
            }
            itemShowViewModel.getUserDetails(for: userId) { (userModel) in // Get User detail from firebase
                self.friendText.text = ("\(userModel.firstName) \(userModel.lastName)") // Update the text label
            }
        }else {
            friendText.text = "\(service.userModel.firstName) \(service.userModel.lastName)"
        }
    }
    
    // Handles the date sector and all logic
    private func dateSectorHandling(itemModel: ItemModel){
        if itemModel.isCompleted { // Task is Completed
            dateLabel.text = "Date Completed:"
            dateText.text = itemModel.dateCompleted
        } else {
            dateLabel.text = "Date Added:"
            dateText.text = itemModel.dateAdded
        }
    }
    
}
