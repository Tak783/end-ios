//
//  RemoteListingsFeedServiceTests.swift
//
//
//  Created by Tak Mazarura on 14/08/2024.
//


import CoreTesting
import CoreNetworking
import ENDListingsFeature
import XCTest
import XCTest

final class RemoteListingsFeedServiceUnitTests: RemoteListingsFeedServiceTests {
    func test_load_onSuccessWithNon200Code_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: RemoteListingsFeedService.Error?
        let exp = expectation(description: "Wait for load completion")
        sut.load { result in
            switch result {
            case .success:
                XCTFail("Expected for Load to fail as StatusCode: 100 should result in a failure")
            case .failure(let error as RemoteListingsFeedService.Error):
                returnedError = error
                exp.fulfill()
            case .failure:
                XCTFail("Expected for Load to fail with RemoteListingsFeedService.Error.invalidResponse error")
            }
        }

        client.complete(withStatusCode: 100, data: .init())
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedError, .invalidResponse)
    }

    func test_load_onSuccessWithNonInvalidData_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: RemoteListingsFeedService.Error?
        let exp = expectation(description: "Wait for load completion")
        sut.load { result in
            switch result {
            case .success:
                XCTFail("Expected for Load to fail as StatusCode: 100 should result in a failure")
            case .failure(let error as RemoteListingsFeedService.Error):
                returnedError = error
                exp.fulfill()
            case .failure:
                XCTFail("Expected for Load to fail with RemoteListingsFeedService.Error.invalidData error")
            }
        }

        client.complete(withStatusCode: 200, data: MockData.any_data(
            for: MockData.FileName.badJSON.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        ))
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedError, .invalidData)
    }

    func test_load_onSuccess_returnsListings() {
        let (sut, client) = make_sut()

        var returnedAccounts: [Account]?
        let exp = expectation(description: "Wait for load completion")
        sut.load { result in
            switch result {
            case .success(let accounts):
                returnedAccounts = accounts
                exp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        let data = MockData.any_data(
            for: MockData.FileName.accounts.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(
            .jsonDateTimeFormatter
        )
        let expectedFeed = try! decoder.decode(TestAccountFeed.self, from: data)
        client.complete(withStatusCode: 200, data: data)
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedAccounts, expectedFeed.accounts.toModels())
    }

    func test_load_onFailure_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: Error?
        let exp = expectation(description: "Wait for load completion")
        sut.load { result in
            switch result {
            case .success:
                XCTFail("Expected for Load to fail as StatusCode: 100 should result in a failure")
            case .failure(let error):
                returnedError = error
                exp.fulfill()
            }
        }

        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)

        wait(for: [exp], timeout: 1.0)

        XCTAssertNotNil(returnedError)
    }
}

// MARK: - Make Sut
extension RemoteListingsFeedServiceTests {
    private func make_sut() -> (sut: RemoteListingsFeedService, client: HTTPClientSpy)  {
        let client = HTTPClientSpy()
        let sut = RemoteListingsFeedService(client: client)
        trackForMemoryLeaks(sut)
        return (sut, client)
    }
}

