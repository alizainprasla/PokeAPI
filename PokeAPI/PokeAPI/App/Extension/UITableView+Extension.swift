//
//  UITableView+Extension.swift
//  PokeAPI
//
//  Created by Alizain on 29/07/2022.
//

import Foundation
import UIKit

protocol ReuseID {
    static var reuseId: String { get }
}

extension ReuseID {
    static var reuseId: String {
        String(describing: Self.self)
    }
}

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
}


extension UICollectionView {
    func configure<Cell, ViewModel>(_ type: Cell.Type, _ viewModel: ViewModel, _ indexPath: IndexPath) -> Cell
        where Cell: UICollectionViewCell, Cell: CellViewModelProtocol, Cell.ViewModel == ViewModel {
        let cell = dequeue(type: Cell.self, for: indexPath)
        cell.config(with: viewModel)
        return cell
    }
    
    func dequeue<Cell>(type: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: ReuseID, Cell: UICollectionViewCell {
        let id = Cell.reuseId
        guard let cell = dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? Cell else {
            fatalError("Dequeue failed for: \(id), at indexPath: \(indexPath.description)")
        }
        return cell
    }
}
