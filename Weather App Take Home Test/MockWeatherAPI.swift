//
//  MockWeatherAPI.swift
//  Weather App Take Home Test
//
//  Created by Tomas Galvan-Huerta on 12/17/24.
//

import Foundation
import Combine


// Move to only unit test
class MockWeatherAPI: WeatherAPI {
    var searchCity:String?
    let responseSubject = PassthroughSubject<Climate, Never>()
    let errorSubject = PassthroughSubject<CallError, Never>()
    
    var response: AnyPublisher<Climate, Never> {
        responseSubject.eraseToAnyPublisher()
    }
    var errorReport: AnyPublisher<CallError, Never> {
        errorSubject.eraseToAnyPublisher()
    }
    
    func search(_ city: String) {
        searchCity = city
    }
    
    var apiKey: String {
        "testAPI"
    }
    
    var baseURL: String {
        "mockBaseURL"
    }
}

extension MockWeatherAPI {
    static let demo: MockWeatherAPI = .init()
}
