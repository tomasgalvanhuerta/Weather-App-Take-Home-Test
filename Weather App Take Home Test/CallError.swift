//
//  CallError.swift
//  Weather App Take Home Test
//
//  Created by Tomas Galvan-Huerta on 12/17/24.
//

import Foundation

public enum CallError: Error {
    case invalidURL
    case notFound
    case timeout
    case notAuthorized
    case callIncomplete
    
    init(_ error: any Error) {
        // If I had more time I would try to figure out
        // A better way to erase any Error with network failures
        self = .callIncomplete
    }
}
