//
//  Favorite.swift
//  KnowYourCountries
//
//  Created by Hana Salhi on 2022-09-19.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @objc dynamic var countryName: String = ""
    
    override static func primaryKey() -> String? {
        return "countryName"
    }
    
    static func isFavorite(countryName: String) -> Bool? {
        try? Realm().object(ofType: Favorite.self, forPrimaryKey: countryName) != nil
    }
    
    static func addFavorite(countryName: String) {
        let realm = try! Realm()
        let favoriteCountry = Favorite(value: ["countryName": countryName])
        try! realm.write {
            realm.add(favoriteCountry)
        }
    }
    
    static func deleteFavorite(countryName: String) {
        let realm = try! Realm()
        if let object = realm.object(ofType: Favorite.self, forPrimaryKey: countryName) {
            try! realm.write {
                realm.delete(object)
            }
        }
    }
}
