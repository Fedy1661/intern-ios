//
//  Doors.swift
//  Cams
//
//  Created by Fedor Konovalov on 23.05.2022.
//

import Foundation
import RealmSwift

struct DoorsResponse: Decodable {
    let data: [Door]
    let success: Bool
    
    func getData() -> [Door] {
        data	
    }
}

final class Door: BaseObject, Decodable, Favorites, Name {
    
    dynamic var id: Int
    dynamic var name: String
    dynamic var room: String?
    dynamic var favorites: Bool
    dynamic var snapshot: String?
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    func toggleFavorite() {
        try! Realm.app.write({
            favorites = !favorites
        })
    }
    
    func updateName(_ name: String) {
        try! Realm.app.write({
            self.name = name
        })
    }
}
