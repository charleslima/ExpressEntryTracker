//
//  ListDrawUseCaseTests.swift
//  ExpressEntryTracker
//
//  Created by Charles Lima on 2024-12-01.
//

import XCTest
@testable import ExpressEntryTracker
import API

class ListDrawUseCaseTests: XCTestCase {

    var sut: ListDrawUseCase!
    var repositoryMock: DrawRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repositoryMock = DrawRepositoryMock()
        sut = ListDrawUseCase(repository: repositoryMock)
    }
    
    override func tearDown() {
        sut = nil
        repositoryMock = nil
        super.tearDown()
    }
    
    func test_execute_whenResponseSucceed_shouldReturnDraws() async throws {
    
        let mockDraws: [API.Draw] = [.mock(drawNumber: "1"), .mock(drawNumber: "2")]
        repositoryMock.mockResult = .success(mockDraws)
        
        let result = try await sut.execute()
        
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].drawNumber, "1")
        XCTAssertEqual(result[1].drawNumber, "2")
    }
    
    func test_execute_whenResponseSucceed_shouldReturnCorrectMappedDraw() async throws {
        
        let now = Date()
        let mockDraws: [API.Draw] = [.mock(drawDistributionAsOn: now)]
        repositoryMock.mockResult = .success(mockDraws)
        
        let result = try await sut.execute()
        
        let expectedResult: [ExpressEntryTracker.Draw] = [
            Draw(
                drawNumber: "327",
                drawNumberURL: "url",
                drawDate: "2024-11-20",
                drawDateFull: "November 20, 2024",
                drawName: "Healthcare occupations (Version 1)",
                drawSize: "3,000",
                drawCRS: "463",
                drawCutOff: "October 21, 2024 at 16:12:39 UTC",
                drawDistributionAsOn: now,
                pool: [
                    .init(range: .dd1, candidates: "100"), .init(range: .dd2, candidates: "16,495"),
                    .init(range: .dd4, candidates: "12,208"), .init(range: .dd5, candidates: "12,318"),
                    .init(range: .dd6, candidates: "15,238"), .init(range: .dd7, candidates: "13,141"),
                    .init(range: .dd8, candidates: "11,691"), .init(range: .dd9, candidates: "57,062"),
                    .init(range: .dd10, candidates: "11,045"), .init(range: .dd11, candidates: "12,196"),
                    .init(range: .dd12, candidates: "11,113"), .init(range: .dd13, candidates: "11,463"),
                    .init(range: .dd14, candidates: "11,245"), .init(range: .dd15, candidates: "51,434"),
                    .init(range: .dd16, candidates: "22,865"), .init(range: .dd17, candidates: "5,615"),
                    .init(range: .dd18, candidates: "218,167")
                ])
            ]
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_execute_whenResponseIsEmpty_returnsEmptyArray() async throws {
        repositoryMock.mockResult = .success([])
        let result = try await sut.execute()
        XCTAssertTrue(result.isEmpty)
    }
    
    func test_execute_whenResponseFails_throwsError() async {
        
        repositoryMock.mockResult = .failure(NSError(domain: "TestError", code: 1, userInfo: nil))
        
        do {
            let _ = try await sut.execute()
            XCTFail("Expected to return error, got success instead.")
        } catch let error {
            XCTAssertEqual((error as NSError).domain, "TestError")
        }
    }


}
