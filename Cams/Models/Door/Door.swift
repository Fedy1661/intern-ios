//
//  Doors.swift
//  Cams
//
//  Created by Fedor Konovalov on 23.05.2022.
//

import Foundation
import RealmSwift

struct DoorsResponse: Decodable {
    let data: [DoorModel]
    let success: Bool
    
    func getData() -> [DoorModel] {
        data
    }
}

struct DoorModel: Decodable {
    var id: Int
    var name: String
    var room: String?
    var favorites: Bool
    var snapshot: String?
}

final class Door: BaseObject, Favorites, Name {
    
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var room: String?
    dynamic var favorites: Bool = false
    dynamic var snapshot: String?
    dynamic var locked: Bool = false
    
    override class func primaryKey() -> String? {
        "id"
    }
}
