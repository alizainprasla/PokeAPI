//
//  Mocks.swift
//  PokeAPITests
//
//  Created by Alizain on 04/08/2022.
//

import XCTest
import RxSwift
import struct RxCocoa.Driver
@testable import PokeAPI

struct MockPokeListUseCase: PokeListUseCase {
    func getCharacterList(limit: Int, offset: Int) -> Single<[PokeCharacter]> {
        return MockLoader
            .load(returnType: PokeListMapper.self, file: "PokeCharacter.json")
            .map { $0.items }
    }
}

struct MockLoader {
    static func load<T: Decodable>(returnType: T.Type, file: String) -> Single<T> {
        return Single.create { single in
            if let path = Bundle(for: PokeListControllerTests.self).path(forResource: file, ofType: "") {
                let data = try? Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                do {
                    let value = try decoder.decode(returnType, from: data!)
                    single(.success(value))
                } catch {
                    single(.failure(error))
                }
                
            }
            return Disposables.create()
        }
    }
}
