//
//  CityView.swift
//  Weather App Take Home Test
//
//  Created by Tomas Galvan-Huerta on 12/17/24.
//

import Foundation
import SwiftUI

struct CityView: View {
    let weatherAPI: WeatherAPI
    @State var climate: Climate?
    
    var body: some View {
        VStack {
            if let climate = climate {
                WeatherIconAsync(condition: climate.current.condition)
                tempAndLocation()
                Text(climate.current.tempeture.formatted())
                    .font(.system(size: 70))
                ClimateCard(condition: climate.current)
            } else {
                Text("No City Selected")
                    .font(.largeTitle)
                Text("Please Search for a City")
            }
        }.onReceive(weatherAPI.response) { climate in
            self.climate = climate
        }
    }
    
    @ViewBuilder // Because of the if
    // Otherwise new SwiftUI @ViewBuilder is not necessary
    func tempAndLocation() -> some View {
        if let climate {
            HStack {
                Text(climate.location.name)
                Image(systemName: "location.fill")
            }
        }
    }
}

struct EmptyCity: View {
    var body: some View {
        Text("")
    }
}


#Preview {
    CityView(weatherAPI: MockWeatherAPI.demo, climate: .demo)
}

#Preview {
    Home(weatherAPI: Forcast())
}
