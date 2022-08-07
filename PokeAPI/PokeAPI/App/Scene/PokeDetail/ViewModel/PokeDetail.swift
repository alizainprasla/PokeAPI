//
//  PokeDetail.swift
//  PokeAPI
//
//  Created by Alizain on 04/08/2022.
//

import UIKit

public struct PokeDetail {
    public let name: String
    public let id: Int
    public let number: String
    public let background: UIColor
    public let thumbnail: URL?
    public let subImage: URL?
    public let stats: Info
    
    public init(mapper: PokeDetailMapper) {
        self.name = mapper.name
        self.background = Color.randomGridColor()
        self.id = mapper.id
        self.number = "\(id)"
        self.thumbnail = CharacterImageURLGenerator.generateImageURL(from: id)
        self.subImage = CharacterImageURLGenerator.generateSubImageURL(from: id)
        self.stats = Info(mapper: mapper)
    }
}

public extension PokeDetail {

    struct Info {
        
        public let stats: [Types]
        
        public init(mapper: PokeDetailMapper) {
            var stats = [Types]()
            
            let pokemonTypes = mapper.types.sorted { $0.slot < $1.slot }.compactMap { PokemonType($0) }
             stats.append(.pokemonTypes(pokemonTypes))

            let mHeight = Float(mapper.height) / 10
            stats.append(.height(mHeight))
            
            let kgWeight = Float(mapper.weight) / 10
            stats.append(.weight(kgWeight))

            var normalAbilities = mapper.abilities.filter { !$0.isHidden  }
            normalAbilities.sort { $0.slot < $1.slot }

            if normalAbilities.count == 1 {
                stats.append(.firstAbility(normalAbilities[0].ability.name.capitalized))
                stats.append(.secondAbility(nil))
            } else if normalAbilities.count > 1 {
                stats.append(.firstAbility(normalAbilities[0].ability.name.capitalized))
                stats.append(.secondAbility(normalAbilities[1].ability.name.capitalized))
            }

            if let hiddenAbility = mapper.abilities.first(where: { $0.isHidden == true }) {
                stats.append(.hiddenAbility(hiddenAbility.ability.name.capitalized))
            } else {
                stats.append(.hiddenAbility(nil))
            }

            self.stats = stats
        }
    }
}

public extension PokeDetail.Info {
    enum Types {
        case pokemonTypes([PokemonType])
        case height(Float)
        case weight(Float)
        case firstAbility(String)
        case secondAbility(String?)
        case hiddenAbility(String?)
        
        var text: String {
            switch self {
            case .pokemonTypes(_):
                return StringResource.types
            case .height(_):
                return StringResource.height
            case .weight(_):
                return StringResource.weight
            case .firstAbility(_):
                return StringResource.ability1
            case .secondAbility(_):
                return StringResource.ability2
            case .hiddenAbility(_):
                return StringResource.hiddenAbility
            }
        }
        
        var image: UIImage? {
            switch self {
            case .pokemonTypes(_):
                return ImageResource.types
            case .height(_):
                return ImageResource.height
            case .weight(_):
                return ImageResource.weight
            case .firstAbility(_):
                return ImageResource.ability1
            case .secondAbility(_):
                return ImageResource.ability2
            case .hiddenAbility(_):
                return ImageResource.hiddenAbility
            }
        }
        
        var value: String {
            switch self {
            case .pokemonTypes(let types):
                return types.map { $0.text }.joined(separator: " / ")
            case .height(let height):
                return String(format: "%.1fm", height)
            case .weight(let kgWeight):
                return String(format: "%.1fkg", kgWeight)
            case .firstAbility(let name):
                return name
            case .secondAbility(let name),
                 .hiddenAbility(let name):
                return name ?? "None"
            }
        }
    }
}
