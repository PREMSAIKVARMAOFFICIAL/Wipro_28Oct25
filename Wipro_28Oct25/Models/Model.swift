//
//  Model.swift
//  Wipro_28Oct25
//
//  Created by Prem Sai K Varma on 10/28/25.
//

import Foundation

struct BankHolidaysResponse: Decodable {
    let englandAndWales: Division
    let scotland: Division
    let northernIreland: Division
    
    enum CodingKeys: String, CodingKey {
        case englandAndWales = "england-and-wales"
        case scotland
        case northernIreland = "northern-ireland"
    }
}

struct Division: Decodable {
    let division: String
    let events: [Holiday]
}

struct Holiday: Decodable, Identifiable, Equatable {
    var id: String {
        "\(date)|\(title)"
    }
    let title: String
    let date: String
    let notes: String?
    let bunting: Bool?
    
    var parsedDate: Date? {
        DateFormatter.bankHoliday.date(
            from: date
        )
    }
}

struct Country: Identifiable {
    let id: DivisionID
    let name: String
    let events: [Holiday]
    
    enum DivisionID: String, CaseIterable {
        case englandAndWales = "england-and-wales"
        case scotland = "scotland"
        case northernIreland = "northern-ireland"
        
        var displayName: String {
            switch self {
            case .englandAndWales: 
                return "England and Wales"
            case .scotland: 
                return "Scotland"
            case .northernIreland: 
                return "Northern Ireland"
            }
        }
    }
}
