//
//  PokeListViewModel.swift
//  PokeAPI
//
//  Created by Alizain on 02/08/2022.
//

import RxSwift
import RxCocoa
import RxDataSources

public struct PokeListViewModel: ViewModelProtocol {
    struct Input {
        let latestItems: Observable<Void>
        let loadMore: Observable<Void>
    }

    struct Output {
        let data: Driver<[SectionModel]>
        let fetching: Driver<Bool>
        let error: Driver<Error>
    }
    
    private let bag = DisposeBag()
    private let pageSize = 20
    let useCase: PokeListUseCase
    let title: String = StringResource.home
    
    func transform(input: Input) -> Output {
        let currentPage = BehaviorRelay<Int>(value: 1)
        let listItems = BehaviorRelay<[PokeCharacter]>(value: [])
        let activityTracker = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let loadMore = input.loadMore
            .do(onNext: {
                let nextPage = currentPage.value + pageSize
                currentPage.accept(nextPage)
            })

        let latestItems = input.latestItems
            .do(onNext: { _ in
                currentPage.accept(1)
            })
                
        Observable.merge(latestItems, loadMore)
            .flatMapLatest { keyword in
                return useCase
                    .getCharacterList(limit: pageSize, offset: currentPage.value)
                    .trackActivity(activityTracker)
                    .trackError(errorTracker)
                    .asDriver(onErrorJustReturn: [])
            }
            .subscribe(onNext: { items in
                var appendedItems = listItems.value
                if (currentPage.value == 1) {
                    appendedItems.removeAll()
                }
                appendedItems.append(contentsOf: items)
                listItems.accept(appendedItems)
            })
            .disposed(by: bag)

        let sectionItems = listItems.map { Items -> [SectionItem] in
            return Items.map {
                SectionItem.item(viewModel: $0)
            }
        }

        let tableData = sectionItems
            .map { [SectionModel(items: $0)] }
            .asDriver(onErrorJustReturn: [])
        
        return Output(data: tableData,
                      fetching: activityTracker.asDriver(),
                      error: errorTracker.asDriver())
    }
}

public extension PokeListViewModel {
    struct SectionModel {
        public var items: [SectionItem]
    }

    enum SectionItem {
        case item(viewModel: PokeCharacter)
    }
}

extension PokeListViewModel.SectionModel: SectionModelType {
    public typealias Item = PokeListViewModel.SectionItem

    public init(original: PokeListViewModel.SectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
