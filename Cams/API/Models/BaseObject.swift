//
//  BaseObject.swift
//  Cams
//
//  Created by Fedor Konovalov on 28.05.2022.
//

import Foundation
import RealmSwift

protocol Favorites {
    dynamic var favorites: Bool { get set }
    
    func toggleFavorite()
}

protocol Name {
    dynamic var name: String { get set }
    
    func update(name: String)
}

typealias Objects = [Object]

@objcMembers
class BaseObject: Object {
    dynamic var createdAt = Date()
    
    static func getAll() -> Objects {
        Array(Realm.app.objects(self))
    }
}
