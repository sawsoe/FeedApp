//
//  Feed.swift
//  FeedApp
//
//  Created by SawSMN's MacBook Pro on 12/5/21.
//

import Foundation

class Feed {
    var userID : Int
    var id : Int
    var title : String
    var body : String
    
    init(userID:Int, id:Int, title:String, body:String) {
        self.userID = userID
        self.id = id
        self.title = title
        self.body = body
        
    }
}
