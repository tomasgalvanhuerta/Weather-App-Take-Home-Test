//
//  Climate.swift
//  Weather App Take Home Test
//
//  Created by Tomas Galvan-Huerta on 12/17/24.
//

import Foundation


/// Abstraction starts having it's limites
/// once the developer has to click several
/// files before getting to the correct implentaton
public struct Climate: Codable {
    let location : Location
    let current: Current
}

extension Climate {
    struct Current: Codable {
        let uv: Double
        let temp_c: Double
        let humidity: Double
        let feelslike_c: Double
        let condition: Condition
        
        var tempeture: Measurement<UnitTemperature> {
            .init(value: temp_c, unit: .celsius)
        }
        
        var humidityPercent: Double {
            humidity/100
        }
    }
    struct Location: Codable {
        let name: String
        let region: String
    }
    struct Condition: Codable {
        let text: String
        let icon: String // Link to thumnail
        let code: Int
    }
}

extension Climate {
    static let demo: Climate = .init(
        location: .demo,
        current: .demo
    )
}


extension Climate.Current {
    static let demo: Self = .init(
        uv: 4.0,
        temp_c: 23.2,
        humidity: 0.34,
        feelslike_c: 25.5,
        condition: .init(text: "Sunny", icon: "", code: 1)
    )
}

extension Climate.Location {
    static let demo: Self = .init(name: "Pokemon", region: "Kanto Region")
}
