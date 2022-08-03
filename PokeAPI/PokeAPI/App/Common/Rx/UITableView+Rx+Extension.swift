//
//  UITableView+Rx+Extensions.swift
//  PokeAPI
//
//  Created by Alizain on 02/08/2022.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    var onReachedEnd: Observable<Void> {
        return base.rx
            .didScroll
            .throttle(.milliseconds(400), scheduler: MainScheduler.instance)
            .map { [weak base] in
                guard let base = base else { return false }
                if base.contentOffset.y + base.frame.size.height - 20 >= base.contentSize.height {
                    return true
                }
                return false
            }
            .filter { $0 }
            .map { _ in }
    }
}

extension Reactive where Base: UICollectionView {
    var onReachedEnd: Observable<Void> {
        return base.rx
            .didScroll
            .throttle(.milliseconds(400), scheduler: MainScheduler.instance)
            .map { [weak base] in
                guard let base = base else { return false }
                if base.contentOffset.y + base.frame.size.height - 20 >= base.contentSize.height {
                    return true
                }
                return false
            }
            .filter { $0 }
            .map { _ in }
    }
}
