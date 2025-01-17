//
//  HomeViewModelTests.swift
//  UalaChallengeTests
//
//  Created by Fede Flores on 17/01/2025.
//

import XCTest
@testable import UalaChallenge

final class HomeViewModelTests: XCTestCase {
    
    var provider: NetworkProviderProtocol?
    var sut: HomeViewModel?
    

    override func setUpWithError() throws {
        provider = NetworkProviderStub()
        sut = HomeViewModel()
        sut?.provider = provider
    }
    
    func testScreenStates() {
        XCTAssertNotNil(sut?.homeState == .loading)
        sut?.fetchPlaces()
        XCTAssertNotNil(sut?.homeState == .success)
    }
    
    func testSortedResponse() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        self.sut?.fetchPlaces()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
            let listResponse = self.sut?.getPlaceList()            
            XCTAssertTrue(listResponse?.first?.name == "Alcoy")
            XCTAssertTrue(listResponse?.last?.name == "Wroclaw")
        }
        wait(for: [expectation], timeout: 5)
    }

    override func tearDownWithError() throws {
        provider = nil
        sut?.provider = nil
        sut = nil
    }
    
}
