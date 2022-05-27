//
//  Database.swift
//  Cams
//
//  Created by CPRO GROUP on 26.05.2022.
//

import Foundation
import RealmSwift

class Database {
    let realm = try! Realm()
    static let shared = Database()
    
    func save(_ data: [Object]) {
        try! realm.write({ realm.add(data, update: .all) })
    }
    
    func get<T: Object>(_ T: T.Type) -> [T] {
        Array(realm.objects(T.self))
    }
        
    func toggleFavorite(item: Object) {
        try! realm.write({
            guard let item = item as? Camera else { return }
            item.favorites = !item.favorites
        })
    }
    
    func updateName(item: Object, name: String) {
        try! realm.write({
            guard let item = item as? Camera else { return }
            item.name = name
        })
    }
    
}
