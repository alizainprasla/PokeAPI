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
        self.background = background
        self.number = CharacterNumberGenerator.generate(from: url)
        self.thumbnail = CharacterImageURLGenerator.generateImageURL(from: number)
        self.subImage = CharacterImageURLGenerator.generateSubImageURL(from: number)
    }
}
