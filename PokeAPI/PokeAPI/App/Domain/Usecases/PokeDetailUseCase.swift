//
//  PokeDetailUseCase.swift
//  PokeAPI
//
//  Created by Alizain on 04/08/2022.
//

import RxSwift

public protocol PokeDetailUseCase {
    func get(id: Int) -> Single<PokeDetail>
}

public class RemotePokeDetailUseCase: PokeDetailUseCase {
    public func get(id: Int) -> Single<PokeDetail> {
        return Single.create { single in
            let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!)) { data, response, error in
                guard error == nil else {
                    single(.failure(error!))
                    return
                }
                do {
                    let object = try PokeDetailMapper.map(data: data ?? Data())
                    single(.success(object.domain))
                } catch let error {
                    single(.failure(error))
                }
            }
            task.resume()
            return Disposables.create()
        }
    }
}
