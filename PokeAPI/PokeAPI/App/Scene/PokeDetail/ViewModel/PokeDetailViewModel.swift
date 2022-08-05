//
//  PokeDetailViewModel.swift
//  PokeAPI
//
//  Created by Alizain on 05/08/2022.
//

import RxSwift
import RxCocoa
import RxDataSources

public struct PokeDetailViewModel: ViewModelProtocol {
    struct Input {
        let load: Observable<Void>
    }

    struct Output {
        let data: Driver<[SectionModel]>
        let fetching: Driver<Bool>
        let error: Driver<Error>
    }
    
    private let bag = DisposeBag()
    
    private let limit = 20
    
    let id: Int
    
    let useCase: PokeDetailUseCase
    
    func transform(input: Input) -> Output {
        let pokemonDetail = ReplaySubject<PokeDetail>.create(bufferSize: 0)
        let activityTracker = ActivityIndicator()
        let errorTracker = ErrorTracker()

        Observable.just(input.load)
            .flatMapLatest { _ in
                return useCase
                    .get(id: id)
                    .trackActivity(activityTracker)
                    .trackError(errorTracker)
            }
            .subscribe { details in
                pokemonDetail.onNext(details)
            }
            .disposed(by: bag)
        
        let data = pokemonDetail
            .asObservable()
            .map { details -> [SectionModel] in
                let items = details.stats.stats.map { SectionItem.detailItem(viewModel: $0) }
                return [SectionModel.HeaderSection(detail: details, items: items)]
            }
            .asDriver(onErrorJustReturn: [])

        return Output(data: data,
                      fetching: activityTracker.asDriver(),
                      error: errorTracker.asDriver())
    }
}



public extension PokeDetailViewModel {
    enum SectionModel {
        case HeaderSection(detail: PokeDetail, items: [SectionItem])
    }
    
    enum SectionItem {
        case detailItem(viewModel: PokeDetail.Info.`Type`)
    }
}

extension PokeDetailViewModel.SectionModel: SectionModelType {
    public typealias Item = PokeDetailViewModel.SectionItem
    
    public var items: [Item] {
        switch self {
        case let .HeaderSection(_ , items):
            return items
        }
    }
    
    public init(original: PokeDetailViewModel.SectionModel, items: [PokeDetailViewModel.SectionItem]) {
      switch  original {
      case let .HeaderSection(detail, items):
          self = .HeaderSection(detail: detail, items: items)
      }
    }
}

