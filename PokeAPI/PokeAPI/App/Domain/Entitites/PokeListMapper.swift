//
//  PokeListMapper.swift
//  PokeAPI
//
//  Created by Alizain on 03/08/2022.
//

import Foundation
import UIKit

// MARK: - PokeListMapper
struct PokeListMapper: Codable {
    let count: Int
    let next, previous: String?
    let results: [Results]
    
    // MARK: - Result
    struct Results: Codable {
        let name: String
        let url: String
        
        func toDomain() -> PokeCharacter {
            return PokeCharacter(name: name, url: url, background: Color.randomGridColor())
        }
    }

    //MARK: - Translator
    var items: [PokeCharacter] {
        return results.map { $0.toDomain() }
    }
    
    //MARK: - Mapper
    static func map(data: Data) throws -> PokeListMapper {
        let decoder = JSONDecoder()
        do {
            let value = try decoder.decode(PokeListMapper.self, from: data)
            return value
        } catch {
            throw error
        }
    }
}
