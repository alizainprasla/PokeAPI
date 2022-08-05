//
//  PokeDetailHeaderView.swift
//  PokeAPI
//
//  Created by Alizain on 05/08/2022.
//

import UIKit

class PokeDetailHeaderView: UITableViewHeaderFooterView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.init(250), for: .horizontal)
        label.setContentCompressionResistancePriority(.init(750), for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 34, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.setContentHuggingPriority(.init(251), for: .horizontal)
        label.setContentCompressionResistancePriority(.init(749), for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pokemonDetailStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        imageView.alpha = 0.06
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    
        pokemonDetailStack.addArrangedSubview(titleLabel)
        pokemonDetailStack.addArrangedSubview(numberLabel)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(pokeImageView)
        contentView.addSubview(pokemonDetailStack)
        contentView.clipsToBounds = true
        contentView.backgroundColor = Color.randomGridColor()
        
        pokemonDetailStack.alignLeadingTrailing(with: contentView, constant: 20)
        pokemonDetailStack.alignTop(with: contentView, constant: 20)
        pokeImageView.centerVertical(with: contentView, constant: 30)
        pokeImageView.centerHorizontal(with: contentView)
        pokeImageView.constrainHeightToWidth(ratio: 1)
        pokeImageView.constrainWidth(to: contentView, ratio: 0.6)
        logoImageView.alignBottom(with: contentView)
        logoImageView.alignTrailing(with: contentView)
        logoImageView.constrainHeightToWidth(ratio: 1)
        logoImageView.constrainWidth(to: contentView, ratio: 0.8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(viewModel: PokeDetail)  {
        titleLabel.text = viewModel.name
        numberLabel.text = "#\(viewModel.number)"
        pokeImageView.kf.setImage(with: viewModel.thumbnail)
    }
}
