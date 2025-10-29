//
//  HolidayRow.swift
//  Wipro_28Oct25
//
//  Created by Prem Sai K Varma on 10/28/25.
//

import SwiftUI

struct HolidayRow: View {
    let holiday: Holiday
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(holiday.title)
                .font(.headline)
            Text(readableDate)
                .font(.subheadline)
            if let notes = holiday.notes, !notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text(notes)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(holiday.title) on \(readableDate)")
    }
    
    private var readableDate: String {
        if let date = holiday.parsedDate {
            return DateFormatter.readable.string(from: date)
        }
        return holiday.date
    }
}

#Preview("Holiday Row") {
    HolidayRow(
        holiday: Holiday(
            title: "New Year’s Day",
            date: "2025-01-01",
            notes: "Bank holiday",
            bunting: true
        )
    )
}
