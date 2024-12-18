//
//  UserDefaultWeather.swift
//  Weather App Take Home Test
//
//  Created by Tomas Galvan-Huerta on 12/18/24.
//

import Foundation

struct UserDefaultWeather {
    static let name = "city.weatherApp.com"
    private let userDefault = UserDefaults.standard
}

extension UserDefaultWeather: CRUDOperation {
    func fetch() -> Result<Climate, UserDefaultError> {
        if let data = userDefault.object(forKey: Self.name) as? Data {
            let decoder = JSONDecoder()
            do {
                let climate = try decoder.decode(Climate.self, from: data)
                return .success(climate)
            } catch {
                return .failure(.memoryCorruption)
            }
            
        } else {
            return .failure(.notFound)
        }
    }
    
    func store(_ climate: Climate) -> Result<Void, UserDefaultError> {
        let jsonEncoder = JSONEncoder()
        do {
            let encoded = try jsonEncoder.encode(climate)
            userDefault.set(encoded, forKey: Self.name)
            return .success(())
        } catch {
            return .failure(.notFound)
        }
        
    }
    
    // Never called but nice to have
    func remove() -> Result<Void, UserDefaultError> {
        userDefault.set(nil, forKey: Self.name)
        return .success(())
    }
}
