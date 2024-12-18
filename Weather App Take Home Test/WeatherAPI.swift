//
//  WeatherAPI.swift
//  Weather App Take Home Test
//
//  Created by Tomas Galvan-Huerta on 12/17/24.
//

import Foundation
import Combine
import SwiftUICore

protocol WeatherAPI {
    var response: AnyPublisher<Climate?, Never> { get }
    var errorReport: AnyPublisher<CallError, Never> { get }
    func search(_ city: String)
    var apiKey: String { get }
    var baseURL: String { get }
}

