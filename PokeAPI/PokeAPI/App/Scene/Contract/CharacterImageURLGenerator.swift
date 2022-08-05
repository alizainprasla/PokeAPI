//
//  CharacterImageURLGenerator.swift
//  PokeAPI
//
//  Created by Alizain on 05/08/2022.
//

import Foundation

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
