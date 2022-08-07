//
//  PokeDetailViewModelTests.swift
//  PokeAPITests
//
//  Created by Alizain on 05/08/2022.
//

import XCTest
import RxTest
import RxBlocking
import RxSwift
import struct RxCocoa.Driver
@testable import PokeAPI

typealias PokeDetailVM = PokeDetailViewModel

class PokeDetailViewModelTests: XCTestCase {

    var testScheduler: TestScheduler!
    var viewModel: PokeDetailVM!
    let bag = DisposeBag()
    
    let id = 132

    override func setUpWithError() throws {
        testScheduler = TestScheduler(initialClock: 0)
        let useCase: PokeDetailUseCase = MockPokeDetailUseCase()
        viewModel = PokeDetailVM(id: id, useCase: useCase)
        
    }

    override func tearDownWithError() throws {
        
        viewModel = nil
        
    }
    
    func test_load_info() throws {
        // Given
        let load = testScheduler
            .createHotObservable([
                .next(0, ())
            ])
            .asObservable()

        let input = PokeDetailVM.Input(load: load)
        let output = viewModel.transform(input: input)

        // When
        testScheduler.start()
        let items = try! output.data.items.toBlocking().first()!
        XCTAssertNotNil(items, "Item should not be nil")
        
        // Then
        XCTAssertEqual(items.count, 6)
    }
    
    func test_load_checkId() throws {
        // Given
        let load = testScheduler
            .createHotObservable([
                .next(0, ())
            ])
            .asObservable()

        let input = PokeDetailVM.Input(load: load)
        let output = viewModel.transform(input: input)

        // When
        testScheduler.start()
        let section = try! output.data.asObservable().toBlocking().first()?.first!
        
        var characterId: Int = -1
        
        switch section {
        case let .HeaderSection(detail: detail, items: _):
            characterId = detail.id
        default:
            break
        }
        XCTAssertNotNil(characterId, "Character Id should not be nil")
        
        // Then
        XCTAssertEqual(characterId, id)
    }
}

private extension Driver where Element == [PokeDetailVM.SectionModel] {
    var items: Observable<[PokeDetail.Info.Types]> {
        return map { sectionModels -> [PokeDetail.Info.Types] in
            return sectionModels[0].items
                .map { sectionItem -> PokeDetail.Info.Types in
                    switch sectionItem {
                    case let .detailItem(viewModel: info):
                        return info
                    }
                }
        }
        .asObservable()
    }
}
