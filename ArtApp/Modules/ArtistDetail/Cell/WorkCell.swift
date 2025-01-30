//
//  WorkCell.swift
//  ArtApp
//
//  Created by Николай Игнатов on 30.01.2025.
//

import UIKit

final class WorkCell: UICollectionViewCell {
    private lazy var workImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 11
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var workLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
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
    
    func configure(with work: Work) {
        workLabel.text = work.title
        workImage.image = UIImage(named: work.image)
    }
}

// MARK: - Private Methods
private extension WorkCell {
    func setupView() {
        contentView.addSubview(workLabel)
        contentView.addSubview(workImage)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            workImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            workImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            workImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            workImage.heightAnchor.constraint(equalToConstant: 150),
            
            workLabel.topAnchor.constraint(equalTo: workImage.bottomAnchor, constant: 10),
            workLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            workLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            workLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
