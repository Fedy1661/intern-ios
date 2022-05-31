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
