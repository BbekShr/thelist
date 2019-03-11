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
        var friendName = "Not Assigned"
        if !itemModel.friendId.isEmpty { // Friend is assigned
            friendName = itemModel.friendId
        }
        friendText.text = friendName
        if itemModel.isCompleted { // Task is Completed
            dateLabel.text = "Date Completed:"
            dateText.text = itemModel.dateCompleted
        } else {
            dateLabel.text = "Date Added:"
            dateText.text = itemModel.dateAdded
        }
    }
    
}
