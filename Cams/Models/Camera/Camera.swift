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
    
    func getData() -> [CameraModel] {
        data.cameras
    }
}

struct CamerasData: Decodable {
    let room: [String]
    let cameras: [CameraModel]
}

struct CameraModel: Decodable {
    let id: Int
    let rec: Bool
    let name: String
    let room: String?
    let snapshot: String
    let favorites: Bool
}

final class Camera: BaseObject, Favorites, Name {
    
    dynamic var id: Int = 0
    dynamic var rec: Bool = false
    dynamic var name: String = ""
    dynamic var room: String?
    dynamic var snapshot: String = ""
    dynamic var favorites: Bool = false
    
    override class func primaryKey() -> String? {
        "id"
    }
}
