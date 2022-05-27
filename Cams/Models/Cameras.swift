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

protocol Indentifier {
    var indentifier: String { get }
}

protocol Favorites {
    dynamic var favorites: Bool { get set }
}

protocol Name {
    dynamic var name: String { get set }
}

class Camera: Object, Decodable, Indentifier, Favorites, Name {
    @objc dynamic var id: Int
    @objc dynamic var rec: Bool
    @objc dynamic var name: String
    @objc dynamic var room: String?
    @objc dynamic var snapshot: String
    @objc dynamic var favorites: Bool
    
    override class func primaryKey() -> String? {
        return "id"
    }

    
    var indentifier: String{ CamCell.identifier}
}
