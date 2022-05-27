//
//  Database.swift
//  Cams
//
//  Created by CPRO GROUP on 26.05.2022.
//

import Foundation
import RealmSwift

extension Realm {
    
    static var app: Realm {
        return try! Realm(configuration: {
            var conf = Configuration()
            conf.deleteRealmIfMigrationNeeded = true
            return conf
        }())
    }
}


final class DBManager {
    private let realm = Realm.app
    static let shared = DBManager()
    
    func get<T: Object>(_ T: T.Type) -> [T] {
        Array(realm.objects(T.self))
    }
}
