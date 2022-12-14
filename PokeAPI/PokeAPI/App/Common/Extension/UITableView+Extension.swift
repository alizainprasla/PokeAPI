//
//  UITableView+Extension.swift
//  PTC_IOS_TEST
//
//  Created by Alizain on 21/06/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation

import UIKit

extension UITableView {
    func dequeue<Cell>(type: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: ReuseID, Cell: UITableViewCell {
        let id = Cell.reuseId
        guard let cell = dequeueReusableCell(withIdentifier: id, for: indexPath) as? Cell else {
            fatalError("Dequeue failed for: \(id), at indexPath: \(indexPath.description)")
        }
        return cell
    }

    func dequeue<Cell>(type: Cell.Type) -> Cell where Cell: ReuseID, Cell: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseId) as? Cell else {
            fatalError("Dequeue failed for: \(Cell.reuseId)")
        }
        return cell
    }

    func dequeue<Cell>(type: Cell.Type) -> Cell where Cell: ReuseID, Cell: UITableViewHeaderFooterView {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: Cell.reuseId) as? Cell else {
            fatalError("HeaderFooter dequeue failed for: \(Cell.reuseId)")
        }
        return cell
    }
}

extension UITableView {
    func configure<Cell, ViewModel>(_ type: Cell.Type, _ viewModel: ViewModel, _ indexPath: IndexPath) -> Cell
        where Cell: UITableViewCell, Cell: CellViewModelProtocol, Cell.ViewModel == ViewModel {
        let cell = dequeue(type: Cell.self, for: indexPath)
        cell.config(with: viewModel)
        return cell
    }
    
//    func register<Cell>(type: Cell.Type, bundle: Bundle = .main) {
//        register(type: Cell.self)
//    }

//    func register<Cell>(type: Cell.Type, identifier: String? = nil, nibName: String? = nil, bundle: Bundle = .main) {
//        let cellName = String(describing: type)
//        let cellIdentifier = identifier ?? cellName
//        let cellNibName = nibName ?? cellName
//        register(UINib(nibName: cellNibName, bundle: bundle), forCellReuseIdentifier: cellIdentifier)
//    }
}
