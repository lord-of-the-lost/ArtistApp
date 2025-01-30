//
//  ArtistCell.swift
//  ArtApp
//
//  Created by Николай Игнатов on 29.01.2025.
//

import UIKit

final class ArtistCell: UICollectionViewCell {
    
    /// Модель для конфигурации ячейки
    struct ArtistCellViewModel {
        let artistImage: UIImage?
        let artistName: String
        let artistDescription: String
    }
    
    private lazy var artistImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(with model: ArtistCellViewModel) {
        nameLabel.text = model.artistName
        descriptionLabel.text = model.artistDescription
        setupArtistImage(with: model.artistImage)
    }
}

// MARK: - Private Methods
private extension ArtistCell {
    func setupView() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(artistImage)
    }
    
    func setupArtistImage(with image: UIImage?) {
        guard let image else {
            artistImage.image = UIImage(systemName: "person.fill")
            return
        }
        artistImage.image = image
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            artistImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            artistImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            artistImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            artistImage.widthAnchor.constraint(equalToConstant: 96),
            artistImage.heightAnchor.constraint(equalToConstant: 96),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -12),
            nameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            descriptionLabel.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 16),
            descriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 48)
        ])
    }
}
