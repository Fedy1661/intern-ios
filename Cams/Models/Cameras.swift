//
//  Cameras.swift
//  Cams
//
//  Created by Fedor Konovalov on 23.05.2022.
//

import Foundation

struct CamerasResponse: Decodable {
    let data: CamerasData
    let success: Bool
}

struct CamerasData: Decodable {
    let room: [String]
    let cameras: [Camera]
}

struct Camera: Decodable {
    let id: Int
    let rec: Bool
    let name: String
    let room: String?
    let snapshot: String
    let favorites: Bool
}
