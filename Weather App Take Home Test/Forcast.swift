//
//  Forcast.swift
//  Weather App Take Home Test
//
//  Created by Tomas Galvan-Huerta on 12/17/24.
//

import Foundation
import Combine
import SwiftUICore

class Forcast: WeatherAPI {
    private let climateSubject = PassthroughSubject<Climate, Never>()
    private let errorSubject = PassthroughSubject<CallError, Never>()
    
    /// mainQueue is added because there are ways to make our test DispatchQueue to advance time with a test implementation
    /// Very important when testing combine logiv
    /// Point Free Guys have a great library for mocking time advancing
    init(_ mainQueue: DispatchQueue = .main) {
        self.mainQueue = mainQueue
    }
    
    // This can be expanded to a background and mainQueue
    let mainQueue: DispatchQueue
    var cancellable: AnyCancellable?

    func search(_ city: String) {
        print("Searching \(city)")
        let adding = "&q=" // Can Turn to Static type or with custom `appending`
        let component = city
        let baseURLWithKey = "\(baseURL)?key=\(apiKey)"
        let final = baseURLWithKey.appending(adding).appending(component)
        let finalURL = URL(string: final)
        guard let finalURL else {
            errorSubject.send(.invalidURL)
            return
        }
        callNetwork(url: finalURL)
    }
    
    private func callNetwork(url: URL) {
        // A new Call will remove the previous publisher work
        // and replaced with new url request
        cancellable = URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Climate.self, decoder: JSONDecoder())
            .mapError(CallError.init)
            .sink { completion in
                // Print is acting as a log
                print("Result to \(url), is \(completion)")
                switch completion {
                case let .failure(error):
                    self.errorSubject.send(error)
                case .finished:
                    break
                }
            } receiveValue: { value in
                self.climateSubject.send(value)
            }
    }
    
    var response: AnyPublisher<Climate, Never> {
        climateSubject
            .share()
            // Throttle to not over send request
            // Can be adjusted
            .throttle(for: .seconds(1), scheduler: RunLoop.main, latest: true)
            .receive(on: mainQueue)
            .eraseToAnyPublisher()
    }
    
    // Over Simiplified Error Report
    var errorReport: AnyPublisher<CallError, Never> {
        errorSubject
            .receive(on: mainQueue)
            .eraseToAnyPublisher()
    }
    
    var apiKey: String {
        "9c9eb8d5d3ba4ebb85622242241812"
    }
    
    var baseURL: String {
        "https://api.weatherapi.com/v1/current.json"
    }
}
