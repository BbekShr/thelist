//
//  CatagoriesViewController.swift
//  The List
//
//  Created by Bibek Shrestha on 3/5/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit

class CatagoriesViewController: UIViewController {

    @IBOutlet weak var categoryTableView: UITableView!
    
    public var categoryArray: [String] = [] // All the category is stored here
    
    private var itemAddViewModel: ItemAddViewModel = ItemAddViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
        itemAddViewModel.getCategoryList(userId: service.userModel.userId) { (categoryList) in
            self.categoryArray = categoryList
            self.categoryTableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
}

extension CatagoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCellId", for: indexPath as IndexPath)
        cell.textLabel?.text = categoryArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
        let storyboard = UIStoryboard(name: "CategoryItems", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CategoryItemId") as! CategoryItemsViewController
        controller.category = categoryArray[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
