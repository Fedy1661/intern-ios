//
//  Image.swift
//  Cams
//
//  Created by Fedor Konovalov on 29.05.2022.
//

import Foundation
import RealmSwift

@objcMembers
class Image: Object {
    dynamic var key: String = NSUUID().uuidString
    dynamic var url: String = ""
    dynamic var data: Data = Data()
    
    override class func primaryKey() -> String? {
        "key"
    }
    
    convenience init(url: String, data: Data) {
        self.init()
        self.url = url
        self.data = data
    }
    
    func save() {
        try! Realm.app.write({
            Realm.app.add(self, update: .modified)
        })
    }
}
