//
//  HolidayListViewModel.swift
//  Wipro_28Oct25
//
//  Created by Prem Sai K Varma on 10/28/25.
//

import Foundation
import Combine

@MainActor
final class HolidayListViewModel: ObservableObject {
    let country: Country
    @Published var query: String = ""
    
    init(country: Country) {
        self.country = country
    }
    
    var filtered: [Holiday] {
        guard !query.isEmpty else {
            return country.events
        }
        return country.events
            .filter { hoilday in
                hoilday.title
                    .localizedCaseInsensitiveContains(query) || (hoilday.notes ?? "").localizedCaseInsensitiveContains(query) || hoilday.date.contains(query)
            }
    }
}
