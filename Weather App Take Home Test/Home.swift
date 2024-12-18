//
//  Home.swift
//  Weather App Take Home Test
//
//  Created by Tomas Galvan-Huerta on 12/17/24.
//

import Foundation
import SwiftUI

struct Home: View {
    let weatherAPI: WeatherAPI
    @State var searching = ""
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(
                    weatherAPI: weatherAPI,
                    searching: $searching
                )
                Spacer()
                CityView(weatherAPI: weatherAPI)
                Spacer()
            }
        }
    }
}

#Preview {
    Home(weatherAPI: MockWeatherAPI.demo)
}

/*
 It would be cool to use be as apple as possible, using .searchable
 Custom Seeach bar it is
 */
