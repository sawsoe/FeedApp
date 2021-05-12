//
//  Feed.swift
//  FeedApp
//
//  Created by SawSMN's MacBook Pro on 12/5/21.
//

import Foundation
import SwiftyJSON

class Feed {
    var userID : Int?
    var id : Int?
    var title : String?
    var body : String?
    var imageUrl: String?
    var thumbnailUrl: String?
    
    init(userID:Int, id:Int, title:String, body:String, imageUrl:String, thumbnailUrl:String) {
        self.userID = userID
        self.id = id
        self.title = title
        self.body = body
        self.imageUrl = imageUrl
        self.thumbnailUrl = thumbnailUrl
        
    }
    
    init() {
        
    }
    
    func fromJSON(jsonData:JSON){
        self.userID = jsonData["userID"].intValue
        self.id = jsonData["id"].intValue
        self.title = jsonData["title"].stringValue
        self.body = jsonData["body"].stringValue
        self.imageUrl = jsonData["imageUrl"].stringValue
        self.thumbnailUrl = jsonData["thumbnailUrl"].stringValue
    }
}
