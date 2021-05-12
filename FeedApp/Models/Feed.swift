//
//  Feed.swift
//  FeedApp
//
//  Created by SawSMN's MacBook Pro on 12/5/21.
//

import Foundation
import SwiftyJSON

///Content to show in News Feed
class Feed {
    /// The userID of the Feed.
    var userID : Int?
    /// The id of the Feed.
    var id : Int?
    /// The title of the Feed.
    var title : String?
    /// The body of the Feed.
    var body : String?
    /// The imageUrl of the Feed.
    var imageUrl: String?
    /// The thumbnailUrl of the Feed.
    var thumbnailUrl: String?
    
    /**
         Initializes a new feed with the provided informations.

         - Parameters:
            - userID: The userID of the Feed
            - id: The id of the Feed
            - title: The title of the Feed
            - body: The body of the Feed
            - imageUrl: The imageUrl of the Feed
            - thumbnailUrl: The thumbnailUrl of the Feed
     

         - Returns: A Feed
         */
    init(userID:Int, id:Int, title:String, body:String, imageUrl:String, thumbnailUrl:String) {
        self.userID = userID
        self.id = id
        self.title = title
        self.body = body
        self.imageUrl = imageUrl
        self.thumbnailUrl = thumbnailUrl
        
    }
    
    /**
         Initializes a new feed without any informations.

         - Returns: An Empty Feed content
         */
    init() {
        
    }
    
    /**
         Initializes a new feed from JSON object.

         - Parameters:
            - jsonData: The JSON object
     

         - Returns: A Feed content
         */
    func fromJSON(jsonData:JSON){
        self.userID = jsonData["userID"].intValue
        self.id = jsonData["id"].intValue
        self.title = jsonData["title"].stringValue
        self.body = jsonData["body"].stringValue
        self.imageUrl = jsonData["imageUrl"].stringValue
        self.thumbnailUrl = jsonData["thumbnailUrl"].stringValue
    }
}
