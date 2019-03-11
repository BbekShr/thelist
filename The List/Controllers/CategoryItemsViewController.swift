//
//  CategoryItemsViewController.swift
//  The List
//
//  Created by IMCS2 on 3/10/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit

class CategoryItemsViewController: UIViewController {
    
    @IBOutlet weak var categoryItemTable: UITableView!
    
    public var titleName: String = ""
    public var category: String = ""
    public var categoryItemsArray: [ItemModel] = []
    private var itemShowViewModel: ItemShowViewModel = ItemShowViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
        self.title = category   //set title
        categoryItemsArray = itemShowViewModel.getItemsByCategory(category: category) // Store the category item in array. Contains completed and not completed task
        let nibname = UINib(nibName: "ItemCellTableViewCell", bundle: nil)
        categoryItemTable.register(nibname, forCellReuseIdentifier: "itemCellId")
    }
}

extension CategoryItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCellId", for: indexPath as IndexPath) as! ItemCellTableViewCell
        cell.commonInit(itemModel: categoryItemsArray[indexPath.row]) // Pass the Item Model
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    
}
