//
//  CallError.swift
//  Weather App Take Home Test
//
//  Created by Tomas Galvan-Huerta on 12/17/24.
//

import Foundation

public enum CallError: Error, CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .notFound: return "Not Found"
        case .timeout: return "Timeout"
        case .notAuthorized: return "Not Authorized"
        case .callIncomplete: return "Incomplete Call"
        }
    }
    
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
