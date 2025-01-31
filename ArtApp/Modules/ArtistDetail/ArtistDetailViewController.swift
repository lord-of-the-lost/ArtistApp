//
//  ArtistDetailViewController.swift
//  ArtApp
//
//  Created by Николай Игнатов on 30.01.2025.
//

import UIKit

final class ArtistDetailViewController: UIViewController {
    private let viewModel: ArtistDetailViewModel
    private weak var coordinator: AppCoordinator?
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var autorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        label.text = "Autor"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.text = "Biography"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var biographyText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var worksLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.text = "Works"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var worksCollectionView: UICollectionView = {
        let itemWidth = UIScreen.main.bounds.width - 40
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemWidth, height: 180)
        layout.minimumLineSpacing = 26
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WorkCell.self, forCellWithReuseIdentifier: "WorkCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(viewModel: ArtistDetailViewModel, coordinator: AppCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        configureView()
    }
}

// MARK: - UICollectionViewDataSource
extension ArtistDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.works.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkCell", for: indexPath) as? WorkCell else { return UICollectionViewCell() }
        cell.configure(with: viewModel.works[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ArtistDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let work = viewModel.works[indexPath.item]
        coordinator?.showPictureDetail(work)
    }
}

// MARK: - Private Methods
private extension ArtistDetailViewController {
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(backButton)
        imageView.addSubview(nameLabel)
        imageView.addSubview(autorLabel)
        view.addSubview(biographyLabel)
        view.addSubview(biographyText)
        view.addSubview(worksLabel)
        view.addSubview(worksCollectionView)
    }
    
    func configureView() {
        imageView.image = viewModel.getArtistImage()
        nameLabel.text = viewModel.artistName
        biographyText.text = viewModel.artistBio
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 384),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            backButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            autorLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 26),
            autorLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -24),
            
            nameLabel.bottomAnchor.constraint(equalTo: autorLabel.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 26),
            
            biographyLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            biographyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            biographyText.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor, constant: 8),
            biographyText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            biographyText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            worksLabel.topAnchor.constraint(equalTo: biographyText.bottomAnchor, constant: 16),
            worksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            worksCollectionView.topAnchor.constraint(equalTo: worksLabel.bottomAnchor, constant: 8),
            worksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            worksCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            worksCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func backButtonTapped() {
        coordinator?.popCurrentViewController()
    }
}
