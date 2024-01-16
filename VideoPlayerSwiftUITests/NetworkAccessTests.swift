//
//  NetworkAccessTests.swift
//  VideoPlayerSwiftUITests
//
//  Created by Greg Rodrigues on 2024-01-14.
//

import XCTest
@testable import VideoPlayerSwiftUI

final class NetworkAccessTests: XCTestCase {

    let timeout = 10.0

    func testGetVideos() {
        let expectation = XCTestExpectation(description: "Response contains videos")
        
        NetworkAccess.shared.getVideos(completion: { result in
            switch result {
            case .success(let videos):
                if videos.count > 0 {
                    expectation.fulfill()
                } else {
                    XCTFail("Videos not found")
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
        })
        
        wait(for: [expectation], timeout: timeout)
    }
}
