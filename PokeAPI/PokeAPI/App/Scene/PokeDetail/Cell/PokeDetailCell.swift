//
//  PokeDetailCell.swift
//  PokeAPI
//
//  Created by Alizain on 05/08/2022.
//

import UIKit

class PokeDetailCell: UITableViewCell {
    private let infoStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundView?.backgroundColor = .red
        infoStack.addArrangedSubview(iconImageView)
        infoStack.addArrangedSubview(titleLabel)
        infoStack.addArrangedSubview(numberLabel)
        contentView.addSubview(infoStack)
        iconImageView.constrainWidth(40)
        infoStack.align(with: contentView, constant:20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokeDetailCell: CellViewModelProtocol {
    typealias ViewModel = PokeDetail.Info.Types
    
    func config(with viewModel: ViewModel) {
        iconImageView.image = viewModel.image
        titleLabel.text = viewModel.text.capitalized
        numberLabel.text = viewModel.value
    }
}
