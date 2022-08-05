//
//  ViewModelProtocol.swift
//  PokeAPI
//
//  Created by Alizain on 02/08/2022.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

protocol CellViewModelProtocol: AnyObject, ReuseID {
    associatedtype ViewModel

    func config(with viewModel: ViewModel)
}
