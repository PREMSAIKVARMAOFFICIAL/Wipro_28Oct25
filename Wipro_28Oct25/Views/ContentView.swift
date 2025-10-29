//
//  ContentView.swift
//  Wipro_28Oct25
//
//  Created by Prem Sai K Varma on 10/28/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView(
            viewModel: HomeViewModel(
                repo: BankHolidayRepository(
                    service: BankHolidayService()
                )
            )
        )
    }
}

#Preview {
    ContentView()
        .padding()
}
