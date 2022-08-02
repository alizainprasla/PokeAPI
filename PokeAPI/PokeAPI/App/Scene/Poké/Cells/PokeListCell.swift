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
        contentView.addSubview(titleLabel)
        contentView.addSubview(pokeImageView)
        contentViewRadius()
        titleLabel.alignTop(with: contentView, constant: 10)
        titleLabel.alignLeadingTrailing(with: contentView, constant: 10)
        pokeImageView.alignBottom(with: contentView)
        pokeImageView.alignTrailing(with: contentView)
        pokeImageView.constrainHeightToWidth(ratio: 1)
        pokeImageView.constrainWidth(to: contentView, ratio: 0.6)
    }
    
    func contentViewRadius() {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        layer.cornerRadius = radius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        titleLabel.text = "Bulbasaur"
        pokeImageView.image = UIImage(named: "5")
    }
    
}
