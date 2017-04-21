//
//  Category.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/04/03.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Category:Object{
    dynamic var name: String = ""
    var articles: List<Article> = List<Article>()
    
    
    convenience init(name: String, articles:[Article]){
        self.init()
        self.name = name
        _ = articles.map {self.articles.append($0)}
        
    }
}
