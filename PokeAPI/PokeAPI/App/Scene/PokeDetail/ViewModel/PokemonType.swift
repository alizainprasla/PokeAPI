//
//  PokemonType.swift
//  PokeAPI
//
//  Created by Alizain on 05/08/2022.
//

import Foundation

public enum PokemonType: String {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case unknown
    case shadow

    init?(_ pokemonType: TypeElement) {
        if let type = PokemonType(rawValue: pokemonType.type.name) {
            self =  type
        } else {
            return nil
        }
    }

    public var text: String {
        return self.rawValue.capitalized
    }
}
