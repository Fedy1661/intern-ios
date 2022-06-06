//
//  Decoder.swift
//  Cams
//
//  Created by Fedor Konovalov on 06.06.2022.
//

import Foundation

class Decoder {
    static func decode<T: Decodable>(_ T: T.Type, data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let jsonError {
            print(jsonError)
            return nil
        }
    }
}
