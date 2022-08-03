//
//  PokeListCell.swift
//  PokeAPI
//
//  Created by Alizain on 29/07/2022.
//

import UIKit

class PokeListCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pokeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.cornerRadius()
        contentView.addSubview(titleLabel)
        contentView.addSubview(pokeImageView)
        titleLabel.alignTop(with: contentView, constant: 10)
        titleLabel.alignLeadingTrailing(with: contentView, constant: 10)
        pokeImageView.alignBottom(with: contentView)
        pokeImageView.alignTrailing(with: contentView)
        pokeImageView.constrainHeightToWidth(ratio: 1)
        pokeImageView.constrainWidth(to: contentView, ratio: 0.6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PokeListCell: CellViewModelProtocol {
    func config(with viewModel: PokeCharacter) {
        titleLabel.text = viewModel.name
        pokeImageView.image = UIImage(named: "5")
        contentView.backgroundColor = viewModel.background
    }
}
