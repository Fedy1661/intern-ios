//
//  Cameras.swift
//  Cams
//
//  Created by Fedor Konovalov on 23.05.2022.
//

import Foundation
import RealmSwift

struct CamerasResponse: Decodable {
    let data: CamerasData
    let success: Bool
    
    func getData() -> [Camera] {
        data.cameras
    }
}

struct CamerasData: Decodable {
    let room: [String]
    let cameras: [Camera]
}

protocol Favorites {
    dynamic var favorites: Bool { get set }
    
    func toggleFavorite()
}

protocol Name {
    dynamic var name: String { get set }
    
    func updateName(_ name: String)
}

@objcMembers
class BaseObject: Object {
    dynamic var createdAt = Date()
    
    static func save(_ data: [Object]) {
        try! Realm.app.write({
            Realm.app.add(data, update: .modified)
        })
    }
    
    static func getAll() -> [Object] {
        Array(Realm.app.objects(self))
    }
}

final class Camera: BaseObject, Decodable, Favorites, Name {
    
    dynamic var id: Int
    dynamic var rec: Bool
    dynamic var name: String
    dynamic var room: String?
    dynamic var snapshot: String
    dynamic var favorites: Bool
    
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
