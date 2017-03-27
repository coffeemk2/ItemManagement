//
//  User.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/03/22.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class User :Object{
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var fullname: String = ""
    dynamic var urlString: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: String,name: String, fullname: String,url: String) {
        self.init()
        self.id = id
        self.name = name
        self.fullname = fullname
        self.urlString = url
    }
    
    static func parseJSON(json: JSON)->User?{
        if json["deleted"].boolValue || json["is_bot"].boolValue{
            return nil
        }
        let user = User()
        user.id = json["id"].stringValue
        user.name = json["name"].stringValue
        user.fullname = json["profile"]["real_name"].stringValue
        user.urlString = json["profile"]["image_192"].stringValue
        return user
    }

}
