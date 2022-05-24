//
//  Doors.swift
//  Cams
//
//  Created by Fedor Konovalov on 23.05.2022.
//

import Foundation

struct DoorsResponse: Decodable {
    let data: [Door]
    let success: Bool
}

struct Door: Decodable {
    let id: Int
    let name: String
    let room: String?
    let favorites: Bool
    let snapshot: String?
}
