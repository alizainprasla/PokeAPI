//
//  RemotePokeListUseCase.swift
//  PokeAPI
//
//  Created by Alizain on 03/08/2022.
//

import RxSwift

public protocol PokeListUseCase {
    func getCharacterList(limit: Int, offset: Int) -> Single<[PokeCharacter]>
}

public class RemotePokeListUseCase: PokeListUseCase {
    public func getCharacterList(limit: Int, offset: Int) -> Single<[PokeCharacter]> {
        return Single.create { single in
            let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)")!)) { data, response, error in
                guard error == nil else {
                    single(.failure(error!))
                    return
                }
                do {
                    let object = try PokeListMapper.map(data: data ?? Data())
                    single(.success(object.items))
                } catch let error {
                    single(.failure(error))
                }
            }
            task.resume()
            return Disposables.create()
        }
    }
}
