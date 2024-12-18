//
//  ContentView.swift
//  Weather App Take Home Test
//
//  Created by Tomas Galvan-Huerta on 12/15/24.
//

import SwiftUI

struct ContentView: View {
    @State var showAlert: Bool = false
    @State var climateAlert: CallError?
    let weatherAPI: WeatherAPI = Forcast()
    var body: some View {
        Home(weatherAPI: weatherAPI)
        // Did not have time to test this, hopefully it works haha
            .alert(
                (climateAlert?.description ?? "Unknown Error"),
                isPresented: $showAlert,
                presenting: climateAlert
            ) { error in
                Button(role: .cancel) {
                    // Handle errors here
                } label: {
                    Text("Ok")
                }
            }
            .onReceive(weatherAPI.errorReport) { alert in
                self.climateAlert = alert
                self.showAlert = true
            }
    }
}

#Preview {
    ContentView()
}
