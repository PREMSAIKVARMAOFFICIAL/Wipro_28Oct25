//
//  HomeView.swift
//  Wipro_28Oct25
//
//  Created by Prem Sai K Varma on 10/28/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("UK Bank Holidays")
                .toolbar {
                    ToolbarItem(
                        placement: .topBarTrailing
                    ) {
                        refreshButton
                    }
                }
        }
        .task {
            await viewModel.load()
        }
    }
    
    @ViewBuilder var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView("Loading…").frame(maxWidth: .infinity, maxHeight: .infinity)
        case .failed(let message):
            VStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle")
                Text("Failed to load")
                Text(message).font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center)
                Button("Retry") {
                    Task {
                        await viewModel.load()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded(let countries):
            List(countries) { country in
                NavigationLink(country.name) {
                    HolidayListView(viewModel: HolidayListViewModel(country: country))
                }
                .accessibilityIdentifier("country_\(country.id.rawValue)")
            }
            .listStyle(.insetGrouped)
        }
    }
    
    var refreshButton: some View {
        Button(
            action: {
                Task {
                    await viewModel.load()
                }
            }) {
                Image(systemName: "arrow.clockwise")
            }
            .accessibilityIdentifier("refresh_button")
    }
}

#Preview("Home View") {
    let repo = BankHolidayRepository(
        service: BankHolidayService(
            client: MockHTTPClient {
                Data(MockData.validJSON)
            }
        )
    )
    let viewModel = HomeViewModel(repo: repo)
    HomeView(viewModel: viewModel)
}
