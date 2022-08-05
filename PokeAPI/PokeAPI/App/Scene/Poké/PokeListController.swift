//
//  PokemonListController.swift
//  PokeAPI
//
//  Created by Alizain on 29/07/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class PokeListController: UIViewController {
    private let spinner = UIActivityIndicatorView(style: .medium)

    private let emptyDataLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let columns: CGFloat = self.view.bounds.width > 760 ? 3 : 2
        let cellSpacing = self.view.width * 0.012
        let inset = self.view.width * 0.05
        let width = (self.view.width / columns) - cellSpacing - inset
        let height = (self.view.width / columns) * 0.6
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        layout.itemSize = CGSize(width: width, height: height)
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()

    private var viewModel = PokeListViewModel(useCase: RemotePokeListUseCase())
    
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = viewModel.title
        setupCollectionView()
        bind()
        view.backgroundColor = Color.background
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.align(with: view)
        collectionView.register(PokeListCell.self, forCellWithReuseIdentifier: "PokeListCell")
        collectionView.reloadData()
    }
    
    private func bind() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<PokeListViewModel.SectionModel>(configureCell: { datasource, collectionView, indexPath, _ in
            switch datasource[indexPath] {
            case let .item(viewModel):
                return collectionView.configure(PokeListCell.self, viewModel, indexPath)
            }
        })
        
        collectionView.rx.itemSelected
          .subscribe(onNext: { [weak self] indexPath in
              let section = dataSource.sectionModels[indexPath.section]
              let row = section.items[indexPath.row]
              switch row {
              case let .item(viewModel: vm):
                  let controller = PokeDetailController()
                  controller.id = vm.number
                  self?.navigationController?.pushViewController(controller, animated: true)
              }
          }).disposed(by: bag)
        
        let latestItems = Observable<Void>.just(())
        let loadMore = collectionView.rx.onReachedEnd.do(onNext: nil)
        let input = PokeListViewModel.Input(latestItems: latestItems, loadMore: loadMore)
        let output = viewModel.transform(input: input)
        
        output.data
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)

        output.data
            .map { !($0.first?.items.isEmpty ?? false) }
            .drive(emptyDataLabel.rx.isHidden)
            .disposed(by: bag)

        output.fetching
            .asObservable()
            .bind(to: self.spinner.rx.isHidden)
            .disposed(by: bag)

        output.error
            .asObservable()
            .bind { error in
                self.spinner.isHidden = true
            }
            .disposed(by: bag)
    }
}

