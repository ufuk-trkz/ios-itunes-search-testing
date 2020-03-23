//
//  SearchResultsControllerTests.swift
//  iTunes SearchTests
//
//  Created by Ufuk Türközü on 23.03.20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest
@testable import iTunes_Search

/*
 
 Does decoding work?
 Does decoding fail when givin bad data?
 Does it build the correct URL?
 Does it build the correct URLRequest?
 Are the search results saved properly?
 Is the completion handler called when data is good?
 Is the completion handler called when data is bad?
 Is the completion handler called when networking fails?
 
 */

class SearchResultsControllerTests: XCTestCase {
    
    func testForSomeResults() {
        let controller = SearchResultController()
        let expectation = self.expectation(description: "Wait for results")
        
        controller.performSearch(for: "GarageBand", resultType: .software) {
            //            XCTFail()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    //    func testSpeedOfTypicalRequest() {
    //        measure {
    //            testForSomeResults()
    //        }
    
    func testSpeedOfTypicalRequestMoreAccurately() {
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            let controller = SearchResultController()
            let expectation = self.expectation(description: "Wait for results")
            
            self.startMeasuring()
            
            controller.performSearch(for: "GarageBand", resultType: .software) {
                self.stopMeasuring()
                
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5)
        }
    }
    
    func testValidData() {
        let markDataLoader = MockDataLoader(data: goodResultData, response: nil, error: nil)
        let controller = SearchResultController(dataLoader: markDataLoader)
        let expectation = self.expectation(description: "Wait for results")
        
        controller.performSearch(for: "GarageBand", resultType: .software) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertEqual(controller.searchResults.count, 2, "Expected 2 results for \"GarageBand\"")
        
        let firstResult = controller.searchResults[0]
        
        XCTAssertEqual(firstResult.title, "GarageBand")
        XCTAssertEqual(firstResult.artist, "Apple")
    }
    
    func testInvalidData() {
        let markDataLoader = MockDataLoader(data: badResultData, response: nil, error: nil)
        let controller = SearchResultController(dataLoader: markDataLoader)
        let expectation = self.expectation(description: "Wait for results")
        
        controller.performSearch(for: "GarageBand", resultType: .software) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertEqual(controller.searchResults.count, 0, "Expected 0 results for \"GarageBand\"")
        
    }
    
}
