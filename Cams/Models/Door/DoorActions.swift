//
//  DoorExtension.swift
//  Cams
//
//  Created by Fedor Konovalov on 28.05.2022.
//

import Foundation
import RealmSwift

extension Door {
    func toggleFavorite() {
        try! Realm.app.write({
            favorites = !favorites
        })
    }
    
    func update(name: String) {
        try! Realm.app.write({
            self.name = name
        })
    }
    
    func toggleLock() {
        try! Realm.app.write({
            locked = !locked
        })
    }
    
    func delete() {
        try! Realm.app.write({
            Realm.app.delete(self)
        })
    }
    
    func save() {
        try! Realm.app.write({
            Realm.app.add(self, update: .modified)
        })
    }
}
