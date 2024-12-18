//
//  WeatherIconAsync.swift
//  Weather App Take Home Test
//
//  Created by Tomas Galvan-Huerta on 12/18/24.
//

import SwiftUI

struct WeatherIconAsync: View {
    let condition: Climate.Condition
    var body: some View {
        if let url = URL(string: "https:\(condition.icon)") {
            AsyncImage(url: url)
                .scaledToFit()
                .containerRelativeFrame(.vertical, count: 4, spacing: 0)
                .safeAreaPadding(20)
                .background(Color.clear)
        }
    }
}

#Preview {
    WeatherIconAsync(condition: .init(text: "", icon: "", code: 123))
}
