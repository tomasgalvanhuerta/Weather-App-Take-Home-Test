//
//  ClimateCard.swift
//  Weather App Take Home Test
//
//  Created by Tomas Galvan-Huerta on 12/17/24.
//

import SwiftUI

struct ClimateCard: View {
    var condition: Climate.Current
    var body: some View {
        HStack {
            huminity()
            uv()
            feelsLike()
        }
        .background(Color.gray.opacity(0.1))
        .safeAreaPadding(20)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .opacity(0.7)
    }
    
    func huminity() -> some View {
        VStack {
            Text("Huminity").padding()
            Text(condition.humidityPercent, format: .percent)
        }
    }
    
    func uv() -> some View {
        VStack {
            Text("UV").padding()
            Text(condition.uv, format: .number)
        }
    }
    
    func feelsLike() -> some View {
        VStack {
            Text("Feels Like").padding()
            Text(condition.tempeture.formatted())
        }
    }
}

#Preview {
    ClimateCard(condition: (.demo))
}
