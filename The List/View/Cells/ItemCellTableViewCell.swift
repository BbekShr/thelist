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
        dateText.text = itemModel.dateAdded
        friendText.text = itemModel.friendId
    }
    
}
