//
//  HolidayListView.swift
//  Wipro_28Oct25
//
//  Created by Prem Sai K Varma on 10/28/25.
//

import SwiftUI

struct HolidayListView: View {
    @StateObject var viewModel: HolidayListViewModel
    
    var body: some View {
        List {
            Section {
                TextField("Search by name, note, or date", text: $viewModel.query)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .accessibilityIdentifier("search_field")
            }
            
            ForEach(viewModel.filtered) { holiday in
                HolidayRow(holiday: holiday)
            }
        }
        .navigationTitle(viewModel.country.name)
        .listStyle(.insetGrouped)
    }
}

#Preview("Holiday List View") {
    let country = Country(
        id: .englandAndWales,
        name: "England and Wales",
        events: [
            Holiday(title: "New Year’s Day", date: "2025-01-01", notes: nil, bunting: true),
            Holiday(title: "Good Friday", date: "2025-04-18", notes: "Bank holiday", bunting: true)
        ]
    )
    HolidayListView(
        viewModel: HolidayListViewModel(
            country: country
        )
    )
}
