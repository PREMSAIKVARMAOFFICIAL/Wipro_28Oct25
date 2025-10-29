//
//  Networking.swift
//  Wipro_28Oct25
//
//  Created by Prem Sai K Varma on 10/28/25.
//

import Foundation

protocol HTTPClient {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

protocol BankHolidayServicing {
    func fetchBankHolidays() async throws -> BankHolidaysResponse
}

struct BankHolidayService: BankHolidayServicing {
    private let client: HTTPClient
    private let baseURL = URL(string: "https://www.gov.uk/bank-holidays.json")!
    
    init(client: HTTPClient = URLSession.shared) {
        self.client = client
    }
    
    func fetchBankHolidays() async throws -> BankHolidaysResponse {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await client.data(for: request)
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        return try decoder.decode(BankHolidaysResponse.self, from: data)
    }
}
