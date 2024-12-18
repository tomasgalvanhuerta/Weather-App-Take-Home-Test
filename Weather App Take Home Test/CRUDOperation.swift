//
//  CRUDOperation.swift
//  Weather App Take Home Test
//
//  Created by Tomas Galvan-Huerta on 12/18/24.
//

import Foundation

protocol CRUDOperation {
    func fetch() -> Result<Climate, UserDefaultError>
    func store(_ climate: Climate) -> Result<Void, UserDefaultError>
    func remove() -> Result<Void, UserDefaultError>
}
