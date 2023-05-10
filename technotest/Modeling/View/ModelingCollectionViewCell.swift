//
//  ModelingCollectionViewCell.swift
//  technotest
//
//  Created by macbook Denis on 5/10/23.
//

import UIKit

class ModelingCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "modelingCollectionViewCell"
    
    private lazy var imageView = UIImageView()
    private var currentImage: UIImage?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8.0

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0
        contentView.addSubview(stackView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = currentImage
        

        stackView.addArrangedSubview(imageView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.0),
        ])
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(indexPath: IndexPath, person: Person) {
        imageView.image = UIImage(named: person.image)
    }
}
