//
//  PokemonListController.swift
//  PokeAPI
//
//  Created by Alizain on 29/07/2022.
//

import UIKit

class PokeListController: UIViewController {
    
    lazy var layout: UICollectionViewFlowLayout = {
        let cellSpacing = self.view.width * 0.012
        let inset = self.view.width * 0.05
        let width = (self.view.width / 2) - cellSpacing - inset
        let height = (self.view.width / 2 ) * 0.6
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Hello"
        setupCollectionView()
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    }
    
    func setupCollectionView() {
        collectionView.register(PokeListCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.align(with: view)
        collectionView.reloadData()
    }
}

extension PokeListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PokeListCell
        
        let number = Int.random(in: 0..<777)
        if number % 2 == 0 && number % 5 != 0 {
            cell.backgroundColor = UIColor(red: 72/255, green: 208/255, blue: 177/255, alpha: 1)
        } else {
            cell.backgroundColor = UIColor(red: 255/255, green: 108/255, blue: 110/255, alpha: 1)
        }
        
        cell.configure()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
}
