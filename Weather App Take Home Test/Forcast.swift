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
    let crudOperation: CRUDOperation
    
    private let climateSubject = CurrentValueSubject<Climate?, Never>(nil)
    private let errorSubject = PassthroughSubject<CallError, Never>()
    
    /// mainQueue is added because there are ways to make our test DispatchQueue to advance time with a test implementation
    /// Very important when testing combine logiv
    /// Point Free Guys have a great library for mocking time advancing
    init(
        _ mainQueue: DispatchQueue = .main,
        _ crudOperation: CRUDOperation = UserDefaultWeather()
    ) {
        self.mainQueue = mainQueue
        self.crudOperation = crudOperation
        start()
    }
    
    private func start() {
        switch crudOperation.fetch() {
        case let .success(climate):
            climateSubject.send(climate)
        case let .failure(error):
            // Not enough time, need to do some mapping from Error to Error
            errorSubject.send(.notFound)
        }
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
    
    var response: AnyPublisher<Climate?, Never> {
        climateSubject
            .share()
            // Throttle to not over send request
            // Can be adjusted
            .throttle(for: .seconds(1), scheduler: RunLoop.main, latest: true)
            .map({ climate in
                if let climate {
                    let result = self.crudOperation.store(climate)
                    print(result) // Not enough time!
                } else {
                    let result = self.crudOperation.remove()
                    print(result) // Not enough time!
                }
                return climate
            })
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
