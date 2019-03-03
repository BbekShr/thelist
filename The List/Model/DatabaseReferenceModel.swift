//
//  DatabaseReference.swift
//  The List
//
//  Created by IMCS2 on 3/3/19.
//  Copyright © 2019 123 Apps Studio LLC. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabaseReferenceModel {
    var ref: DatabaseReference
    
    init(){
        ref = Database.database().reference()
    }
}
