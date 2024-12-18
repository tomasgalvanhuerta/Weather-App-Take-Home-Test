//
//  SearchBar.swift
//  Weather App Take Home Test
//
//  Created by Tomas Galvan-Huerta on 12/17/24.
//
import SwiftUI

struct SearchBar: View {
    let weatherAPI: WeatherAPI
    @Binding var searching: String
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .opacity(0.1)
            .frame(height: 45)
            .overlay(alignment: .center) {
                HStack {
                    TextField("Search Location", text: $searching)
                        .onSubmit {
                            weatherAPI.search(searching)
                        }
                        .onChange(of: searching) { oldValue, newValue in
                            guard oldValue != searching else { return }
                            searching = newValue
                            // Add suggestions here
                        }
                        .padding()
                    Spacer()
                    Image(systemName: Self.magnifyingGlass)
                        .padding()
                        .foregroundStyle(.gray)
                }
            }
            .safeAreaPadding(.horizontal, 30)
    }
}

extension SearchBar {
    static let magnifyingGlass = "magnifyingglass"
}

#Preview(body: {
    SearchBar(weatherAPI: MockWeatherAPI.demo, searching: .constant(""))
})
