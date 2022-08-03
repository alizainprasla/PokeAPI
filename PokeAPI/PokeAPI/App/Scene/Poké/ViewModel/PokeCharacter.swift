//
//  PokeCharacter.swift
//  PokeAPI
//
//  Created by Alizain on 03/08/2022.
//

import UIKit

public struct PokeCharacter {
    let name: String
    let url: URL?
    let number: Int
    let background: UIColor
    let thumbnail: URL?
    let subImage: URL?
    
    internal init(name: String, url: String, background: UIColor) {
        self.name = name
        self.url = URL(string: url)
        self.number = CharacterNumberGenerator.generate(from: url)
        self.background = background
        self.thumbnail = CharacterImageURLGenerator.generateImageURL(from: number)
        self.subImage = CharacterImageURLGenerator.generateSubImageURL(from: number)
    }
}

public struct CharacterImageURLGenerator {
    static func generateThumbnailURL(from id: Int) -> URL? {
        let formatId = String(format: "%03d", id)
        let imageUrl = "https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/thumbnails/\(formatId).png"
        return URL(string: imageUrl)
    }

    static func generateImageURL(from id: Int) -> URL? {
        let formatId = String(format: "%03d", id)
        let imageUrl = "https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/\(formatId).png"
        return URL(string: imageUrl)
    }

    static func generateSubImageURL(from id: Int) -> URL? {
        let imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        return URL(string: imageUrl)
    }
}

public struct CharacterNumberGenerator {

    static func generate(from url: String) -> Int {
        guard !url.isEmpty else {
            return 0
        }

        if let number = self.generate(fromPokemon: url) {
            return number
        }
        if let number = self.generate(fromPokemonSpecies: url) {
            return number
        }
        return 0
    }

    private static func generate(fromPokemon url: String) -> Int? {
        var removePrefix = url.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: "")
        removePrefix.removeLast()
        return Int(removePrefix)
    }

    private static func generate(fromPokemonSpecies url: String) -> Int? {
        var removePrefix = url.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon-species/", with: "")
        removePrefix.removeLast()
        return Int(removePrefix)
    }
}
