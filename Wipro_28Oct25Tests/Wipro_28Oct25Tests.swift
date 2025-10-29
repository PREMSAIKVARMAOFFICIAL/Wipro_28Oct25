//
//  Wipro_28Oct25Tests.swift
//  Wipro_28Oct25Tests
//
//  Created by Prem Sai K Varma on 10/28/25.
//

import XCTest
@testable import Wipro_28Oct25

@MainActor
final class Wipro_28Oct25Tests: XCTestCase {
    
    var repo: BankHolidayRepository!
    var service: BankHolidayService!
    
    override func setUpWithError() throws {
        let client = MockHTTPClient {
            MockData.validJSON
        }
        service = BankHolidayService(client: client)
        repo = BankHolidayRepository(service: service)
    }
    
    override func tearDownWithError() throws {
        repo = nil
        service = nil
    }
    
    func testDecodingResponse() throws {
        let data = MockData.validJSON
        let decoder = JSONDecoder()
        
        let decoded = try decoder.decode(BankHolidaysResponse.self, from: data)
        
        XCTAssertEqual(decoded.englandAndWales.division, "england-and-wales")
        XCTAssertEqual(decoded.scotland.events.first?.title, "St Andrew’s Day")
        XCTAssertEqual(decoded.northernIreland.events.count, 1)
    }
    
    func testRepositoryMapsCountriesCorrectly() async throws {
        let countries = try await repo.countries()
        
        XCTAssertEqual(countries.count, 3)
        XCTAssertEqual(countries.first?.name, "England and Wales")
        XCTAssertEqual(countries.first?.events.first?.title, "New Year’s Day")
        XCTAssertEqual(countries.last?.id, .northernIreland)
    }
    
    func testHomeViewModelLoadsSuccessfully() async throws {
        let viewModel = HomeViewModel(repo: repo)
        
        await viewModel.load()
        
        switch viewModel.state {
        case .loaded(let countries):
            XCTAssertEqual(countries.count, 3)
            XCTAssertEqual(countries[0].events[0].title, "New Year’s Day")
        default:
            XCTFail("Expected .loaded state, got \(viewModel.state)")
        }
    }
    
    func testHolidayListFiltering() async {
        let holidays = [
            Holiday(title: "New Year’s Day", date: "2025-01-01", notes: "Public holiday", bunting: true),
            Holiday(title: "Christmas Day", date: "2025-12-25", notes: "Xmas", bunting: true)
        ]
        let country = Country(
            id: .englandAndWales,
            name: "England and Wales",
            events: holidays
        )

        let viewModel = HolidayListViewModel(country: country)
        await MainActor.run {
            viewModel.query = "christmas"
        }
        
        XCTAssertEqual(viewModel.filtered.count, 1, "Expected only Christmas Day to match")
        XCTAssertEqual(viewModel.filtered.first?.title, "Christmas Day")
    }

    func testPerformanceExample() throws {
        measure {
            _ = try? JSONDecoder().decode(BankHolidaysResponse.self, from: MockData.validJSON)
        }
    }
}
