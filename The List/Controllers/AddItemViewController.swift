//
//  AddItemViewController.swift
//  The List
//
//  Created by IMCS2 on 3/4/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import UIKit
import iOSDropDown

class AddItemViewController: UIViewController {

    @IBOutlet weak var categoryDropDown: DropDown!
    @IBOutlet weak var friendDropDown: DropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
        renderCategoryDropDown()
        renderFriendDropDown()
        // Do any additional setup after loading the view.
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddItemViewController{
    
}

extension AddItemViewController{
    private func renderCategoryDropDown(){
        categoryDropDown.optionArray = ["Milk", "Product", "Shopping", "Permanent Access"]
        categoryDropDown.optionIds = [5,6,7,8]
        categoryDropDown.didSelect { (selectText, index, id) in
            print(selectText)
            print(index)
            print(id)
        }
    }
    
    private func renderFriendDropDown(){
        friendDropDown.optionArray = ["Amazing", "Product", "Gallery", "Permanent Access"]
        friendDropDown.optionIds = [5,6,7,8]
        friendDropDown.didSelect { (selectText, index, id) in
            print(selectText)
            print(index)
            print(id)
        }
    }
}
