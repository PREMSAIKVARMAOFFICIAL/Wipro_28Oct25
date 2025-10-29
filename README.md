# Wipro_28Oct25 – SwiftUI (MVVM + async/await)

## Overview
This iOS app displays **official UK Bank Holidays** (England & Wales, Scotland, Northern Ireland) by fetching live data from the UK Government API:  
🔗 [https://www.gov.uk/bank-holidays.json](https://www.gov.uk/bank-holidays.json)

It’s built using **SwiftUI**, **MVVM**, **async/await**, and **unit testing** — demonstrating modern iOS architecture and concurrency patterns.

---

## Features
- **Home Screen:** Lists all UK regions with navigation.
- **Holiday List:** Displays holidays for selected country with name, date, and notes.
- **Search Bar:** Filters holidays by name, date, or note.
- **Refresh Button:** Reloads data via async/await.
- **Unit Tests:** Validates decoding, repository, and view model logic.
- **Mock Data Previews:** Work without live API.

---

## Layers
View: SwiftUI Views (HomeView, HolidayListView, HolidayRow)
ViewModel: State & Logic (HomeViewModel, HolidayListViewModel)
Repository: Maps service data to domain models
Service: Handles networking (async/await)
Model: Codable entities (BankHolidaysResponse, Holiday, Country)


## Unit Testing - Covered Tests
| Test Function                            | Description                       |
| ---------------------------------------- | --------------------------------- |
| `testDecodingResponse()`                 | Validates JSON decoding.          |
| `testRepositoryMapsCountriesCorrectly()` | Ensures repository mapping logic. |
| `testHomeViewModelLoadsSuccessfully()`   | Checks view model load state.     |
| `testHolidayListFiltering()`             | Validates search filtering logic. |
| `testPerformanceExample()`               | Measures JSON decoding speed.     |


## Folder Structure
Wipro_28Oct25/
│
├── Models/
│   ├── BankHolidaysResponse.swift
│   ├── Holiday.swift
│   ├── Country.swift
│
├── Services/
│   ├── BankHolidayService.swift
│   ├── HTTPClient.swift
│
├── Repository/
│   ├── BankHolidayRepository.swift
│
├── ViewModels/
│   ├── HomeViewModel.swift
│   ├── HolidayListViewModel.swift
│
├── Views/
│   ├── HomeView.swift
│   ├── HolidayListView.swift
│   ├── HolidayRow.swift
│
├── PreviewMocks.swift
├── Wipro_28Oct25App.swift
├── README.md
└── Tests/
    ├── Wipro_28Oct25Tests.swift


## Tech Stack
| Component    | Technology        |
| ------------ | ----------------- |
| UI           | SwiftUI           |
| Architecture | MVVM + Repository |
| Concurrency  | async/await       |
| Network      | URLSession        |
| Data Parsing | Codable           |
| Testing      | XCTest            |
| Language     | Swift 5.9         |
| Platform     | iOS 17+           |
| IDE          | Xcode 16+         |

## Architecture (MVVM + Repository Pattern)

```text
SwiftUI View  →  ViewModel  →  Repository  →  Service  →  API
