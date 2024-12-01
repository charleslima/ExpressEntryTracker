//
//  GetPoolHistoryUseCaseTests.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-12-01.
//

import XCTest
@testable import ExpressEntryTracker

class GetPoolHistoryUseCaseTests: XCTestCase {
    
    var sut: GetPoolHistoryUseCase!

    override func setUp() {
        super.setUp()
        sut = GetPoolHistoryUseCase()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_execute_whenDataIsValid_shouldReturnPoolHistory() {
        
        let rangeUnderTest = ScoreRange.dd1
        let rangeToIgnore = ScoreRange.dd10
        
        let mockDraws: [Draw] = [
            .mock(drawNumber: "2", drawDistributionAsOn: Date(timeIntervalSince1970: 2000), pool: [.init(range: rangeUnderTest, candidates: "20")]),
            .mock(drawNumber: "1", drawDistributionAsOn: Date(timeIntervalSince1970: 1000), pool: [.init(range: rangeUnderTest, candidates: "10")]),
            .mock(drawNumber: "3", drawDistributionAsOn: Date(timeIntervalSince1970: 3000), pool: [.init(range: rangeToIgnore, candidates: "30")])
        ]
        
        let result = sut.execute(draws: mockDraws, range: rangeUnderTest)
        
        let expectedResult = PoolHistory(range: rangeUnderTest,
                                         history: [.init(date: Date(timeIntervalSince1970: 1000), candidates: 10),
                                                   .init(date: Date(timeIntervalSince1970: 2000), candidates: 20)])
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_execute_whenDrawsIsEmpty_shouldReturnEmptyHistory() {
        
        let mockDraws: [Draw] = []
        let rangeUnderTest = ScoreRange.dd1
        
        let result = sut.execute(draws: mockDraws, range: rangeUnderTest)
        
        XCTAssertEqual(result.range, rangeUnderTest)
        XCTAssertTrue(result.history.isEmpty)
    }
    
    func test_execute_whenNumberOfCandidatesIsZero_shouldSkipEntry() {
        let rangeUnderTest = ScoreRange.dd1

        let mockDraws: [Draw] = [
            .mock(drawNumber: "2", drawDistributionAsOn: Date(timeIntervalSince1970: 2000), pool: [.init(range: rangeUnderTest, candidates: "20")]),
            .mock(drawNumber: "1", drawDistributionAsOn: Date(timeIntervalSince1970: 1000), pool: [.init(range: rangeUnderTest, candidates: "0")])
        ]
        
        let result = sut.execute(draws: mockDraws, range: rangeUnderTest)
        
        let expectedResult = PoolHistory(range: rangeUnderTest, history: [.init(date: Date(timeIntervalSince1970: 2000), candidates: 20)])
        
        XCTAssertEqual(result, expectedResult)

    }


}
