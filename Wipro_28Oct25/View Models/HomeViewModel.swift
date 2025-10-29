//
//  HomeViewModel.swift
//  Wipro_28Oct25
//
//  Created by Prem Sai K Varma on 10/28/25.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    enum State {
        case idle, loading
        case loaded([Country])
        case failed(String)
    }
    
    @Published private(set) var state: State = .idle
    
    private let repo: BankHolidayRepositorying
    
    init(repo: BankHolidayRepositorying) {
        self.repo = repo
    }
    
    func load() async {
        state = .loading
        do {
            let countries = try await repo.countries()
            state = .loaded(countries)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
