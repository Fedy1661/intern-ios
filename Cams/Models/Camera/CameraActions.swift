//
//  CameraActions.swift
//  Cams
//
//  Created by Fedor Konovalov on 28.05.2022.
//

import Foundation
import RealmSwift

extension Camera {
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
    
    func save() {
        try! Realm.app.write({
            Realm.app.add(self, update: .modified)
        })
    }
}
