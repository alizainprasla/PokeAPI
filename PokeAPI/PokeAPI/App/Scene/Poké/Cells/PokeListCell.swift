//
//  PokeListCell.swift
//  PokeAPI
//
//  Created by Alizain on 29/07/2022.
//

import UIKit
import Kingfisher

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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        let image = ImageResource.logoImage
        image?.withTintColor(.white)
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.07
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.cornerRadius()
        contentView.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(pokeImageView)
        
        titleLabel.alignTop(with: contentView, constant: 10)
        titleLabel.alignLeadingTrailing(with: contentView, constant: 10)
        
        pokeImageView.alignBottom(with: contentView, constant: -5)
        pokeImageView.alignTrailing(with: contentView, constant: -5)
        pokeImageView.constrainHeightToWidth(ratio: 1)
        pokeImageView.constrainWidth(to: contentView, ratio: 0.48)
    
        logoImageView.alignBottom(with: contentView)
        logoImageView.alignTrailing(with: contentView)
        logoImageView.constrainHeightToWidth(ratio: 1)
        logoImageView.constrainWidth(to: contentView, ratio: 0.6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokeListCell: CellViewModelProtocol {
    func config(with viewModel: PokeCharacter) {
        titleLabel.text = viewModel.name
        contentView.backgroundColor = viewModel.background
        pokeImageView.kf.setImage(with: viewModel.thumbnail)
    }
}
