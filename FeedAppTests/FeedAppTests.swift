//
//  FeedAppTests.swift
//  FeedAppTests
//
//  Created by SawSMN's MacBook Pro on 12/5/21.
//

import XCTest
@testable import FeedApp
import SwiftyJSON

class FeedAppTests: XCTestCase {
    
    
    func testFeedObject() throws {
        let feed = Feed(userID: 1, id: 1, title: "feed title", body: "feed body", imageUrl: "imageUrl", thumbnailUrl: "thumbUrl")
        
        XCTAssertEqual(feed.title, "feed title")
    }
    
    func testFeedFromJSON() throws {
        if let path = Bundle.main.path(forResource: "response", ofType: "json") {
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = JSON(data)
                
                let feed:Feed = Feed()
                feed.fromJSON(jsonData: jsonResult.arrayValue[0])
                
                XCTAssertEqual(feed.id, 1)
                
            } catch {
                print("Failed to load data from json file")
            }
        }
    }
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
