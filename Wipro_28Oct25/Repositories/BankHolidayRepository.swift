//
//  BankHolidayRepository.swift
//  Wipro_28Oct25
//
//  Created by Prem Sai K Varma on 10/28/25.
//

import Foundation

protocol BankHolidayRepositorying {
    func countries() async throws -> [Country]
}

struct BankHolidayRepository: BankHolidayRepositorying {
    let service: BankHolidayServicing
    
    func countries() async throws -> [Country] {
        let resp = try await service.fetchBankHolidays()
        return [
            Country(
                id: .englandAndWales,
                name: Country.DivisionID.englandAndWales.displayName,
                events: resp.englandAndWales.events.sorted(
                    by: sortByDateThenTitle
                )
            ),
            Country(
                id: .scotland,
                name: Country.DivisionID.scotland.displayName,
                events: resp.scotland.events.sorted(
                    by: sortByDateThenTitle
                )
            ),
            Country(
                id: .northernIreland,
                name: Country.DivisionID.northernIreland.displayName,
                events: resp.northernIreland.events.sorted(
                    by: sortByDateThenTitle
                )
            )
        ]
    }
    
    private func sortByDateThenTitle(_ input1: Holiday, _ input2: Holiday) -> Bool {
        switch (input1.parsedDate, input2.parsedDate) {
        case let (title1?, title2?):
            if title1 == title2 {
                return input1.title < input2.title
            }
            return title1 < title2
        case (.some, .none):
            return true
        case (.none, .some):
            return false
        default:
            return input1.title < input2.title
        }
    }
}
