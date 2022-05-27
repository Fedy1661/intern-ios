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

class Door: Object, Decodable, Indentifier, Favorites, Name {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var room: String?
    @objc dynamic var favorites: Bool
    @objc dynamic var snapshot: String?
    
    var indentifier: String {
        snapshot != nil ? DoorphoneCell.identifier : EntranceCell.identifier
    }
}
