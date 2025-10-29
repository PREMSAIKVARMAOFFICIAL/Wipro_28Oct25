//
//  Extension.swift
//  Wipro_28Oct25
//
//  Created by Prem Sai K Varma on 10/28/25.
//

import Foundation

extension DateFormatter {
    static let bankHoliday: DateFormatter = {
        let df = DateFormatter()
        df.calendar = Calendar(identifier: .iso8601)
        df.locale = Locale(identifier: "en_GB")
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()
    
    static let readable: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .long
        df.timeStyle = .none
        df.locale = Locale(identifier: "en_GB")
        return df
    }()
}

extension URLSession: HTTPClient {
    //Custom code
}

// MARK: - Mock Types
struct MockHTTPClient: HTTPClient {
    let dataProvider: () throws -> Data

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        let data = try dataProvider()
        let response = HTTPURLResponse(url: request.url!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)!
        return (data, response)
    }
}

enum MockData {
    static let validJSON = """
    {
      "england-and-wales": {
        "division": "england-and-wales",
        "events": [
          { "title": "New Year’s Day", "date": "2025-01-01", "notes": "Public holiday", "bunting": true }
        ]
      },
      "scotland": {
        "division": "scotland",
        "events": [
          { "title": "St Andrew’s Day", "date": "2025-11-30", "notes": "National holiday", "bunting": true }
        ]
      },
      "northern-ireland": {
        "division": "northern-ireland",
        "events": [
          { "title": "St Patrick’s Day", "date": "2025-03-17", "notes": "Bank holiday", "bunting": true }
        ]
      }
    }
    """.data(using: .utf8)!
}
