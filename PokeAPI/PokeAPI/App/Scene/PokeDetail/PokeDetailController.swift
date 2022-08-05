//
//  PokeDetailController.swift
//  PokeAPI
//
//  Created by Alizain on 04/08/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SwiftUI

class PokeDetailController: UIViewController {
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        return view
    }()

    lazy var viewModel: PokeDetailViewModel = {
        return PokeDetailViewModel(id: id, useCase: RemotePokeDetailUseCase())
    }()
    
    private let spinner = UIActivityIndicatorView(style: .medium)
    
    private let bag = DisposeBag()
    
    private var dataSource: RxTableViewSectionedReloadDataSource<PokeDetailViewModel.SectionModel>!
    
    var id: Int = 0
    
    private let emptyDataLabel: UILabel = {
        let label = UILabel()
        label.text = "No Data Found"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addPaginationSpinner()
        setupEmptyDataLabel()
        bind()
        view.backgroundColor = Color.background
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.align(with: view)
        tableView.register(PokeDetailCell.self, forCellReuseIdentifier: "PokeDetailCell")
        tableView.reloadData()
    }
    
    private func addPaginationSpinner() {
        view.addSubview(spinner)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        spinner.centerVertical(with: view)
        spinner.centerHorizontal(with: view)
    }
    
    private func setupEmptyDataLabel() {
        view.addSubview(emptyDataLabel)
        emptyDataLabel.centerVertical(with: view)
        emptyDataLabel.centerHorizontal(with: view)
        emptyDataLabel.alignLeadingTrailing(with: view)
    }
    
    private func bind() {
        dataSource = RxTableViewSectionedReloadDataSource<PokeDetailViewModel.SectionModel>(configureCell: { datasource, tableview, indexPath, _ in
            switch datasource[indexPath] {
            case let .detailItem(viewModel: vm):
                return tableview.configure(PokeDetailCell.self, vm, indexPath)
            }
        })
        
        let load = Observable<Void>.just(())
        let input = PokeDetailViewModel.Input(load: load)
        let output = viewModel.transform(input: input)
        
        output.data
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)

        output.data
            .map { !($0.first?.items.isEmpty ?? false) }
            .drive(emptyDataLabel.rx.isHidden)
            .disposed(by: bag)
        
        output.fetching
            .asObservable()
            .subscribe(onNext: { isFetching in
                if isFetching {
                    self.spinner.startAnimating()
                    
                } else {
                    self.spinner.stopAnimating()
                }
            })
            .disposed(by: bag)

        output.error
            .asObservable()
            .bind { error in
                self.spinner.isHidden = true
                self.emptyDataLabel.isHidden = false
                self.emptyDataLabel.text = error.localizedDescription
            }
            .disposed(by: bag)
    }
}

extension PokeDetailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionData =  dataSource.sectionModels[section]
        switch sectionData {
        case .HeaderSection(let detail, _):
            let headerView = PokeDetailHeaderView(reuseIdentifier: "headerView")
            headerView.config(viewModel: detail)
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.bounds.height * 0.35
    }
}
    
