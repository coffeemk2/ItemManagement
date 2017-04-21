//
//  Item.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/03/31.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Article:Object{
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var image: String = ""
    dynamic var place: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(name: String, image: String, place: String){
        self.init()
        self.id = UUID.init().uuidString
        self.name = name
        self.image = image
        self.place = place
    }
}
