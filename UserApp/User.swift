//
//  User.swift
//  UserApp
//
//  Created by Hana Salhi on 2022-05-18.
//

import Foundation
import RealmSwift

class User: Object {
    
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
    
    override static func primaryKey() -> String? {
        return "email"
    }
    
}
    
