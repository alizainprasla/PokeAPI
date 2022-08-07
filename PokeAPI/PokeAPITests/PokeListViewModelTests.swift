//
//  PokeListControllerTests.swift
//  PokeAPITests
//
//  Created by Alizain on 04/08/2022.
//

import XCTest
import RxTest
import RxBlocking
import RxSwift
import struct RxCocoa.Driver
@testable import PokeAPI

typealias PokeListVM = PokeListViewModel

class PokeListViewModelTests: XCTestCase {

    var testScheduler: TestScheduler!
    var viewModel: PokeListVM!
    let bag = DisposeBag()

    override func setUpWithError() throws {
        testScheduler = TestScheduler(initialClock: 0)
        let useCase: PokeListUseCase = MockPokeListUseCase()
        viewModel = PokeListVM(useCase: useCase)
    }

    override func tearDownWithError() throws {}

    func test_load_latestFeeds() throws {
        // Given
        let latestItems = testScheduler
            .createHotObservable([
                .next(0, ())
            ])
            .asObservable()
        
        let input = PokeListVM.Input(latestItems: latestItems, loadMore: .never())
        let output = viewModel.transform(input: input)

        // When
        testScheduler.start()
        let items = try! output.data.items.toBlocking().first()!

        // Then
        XCTAssertEqual(items.count, 10)
    }

    func test_load_loadMore() throws {
        // Given
        let latestItems = testScheduler
            .createHotObservable([
                .next(0, ())
            ])
            .asObservable()
        
        let loadMore = testScheduler
            .createHotObservable([
                .next(2, ())
            ])
            .asObservable()
        
        let input = PokeListVM.Input(latestItems: latestItems, loadMore: loadMore)
        let output = viewModel.transform(input: input)

        // When
        testScheduler.start()
        let items = try! output.data.items.toBlocking().first()!
        
        // Then
        XCTAssertEqual(items.count, 20)
    }
}

private extension Driver where Element == [PokeListVM.SectionModel] {
    var items: Observable<[PokeCharacter]> {
        return map { sectionModels -> [PokeCharacter] in
            return sectionModels[0].items
                .map { sectionItem -> PokeCharacter in
                    switch sectionItem {
                    case let .item(viewModel: vm):
                        return vm
                    }
                }
        }
        .asObservable()
    }
}
