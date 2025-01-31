//
//  PictureDetailViewController.swift
//  ArtApp
//
//  Created by Николай Игнатов on 31.01.2025.
//

import UIKit

final class PictureDetailViewController: UIViewController {
    private let viewModel: PictureDetailViewModel
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
    
    private lazy var pictureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var expandButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Развернуть", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: PictureDetailViewModel, coordinator: AppCoordinator) {
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

// MARK: - Private Methods
private extension PictureDetailViewController {
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(backButton)
        view.addSubview(pictureLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(expandButton)
        
    }
    
    func configureView() {
        imageView.image = viewModel.getPictureImage()
        pictureLabel.text = viewModel.pictureName
        descriptionLabel.text = viewModel.pictureDescription
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            backButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            pictureLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            pictureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pictureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: pictureLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            expandButton.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 20),
            expandButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            expandButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            expandButton.heightAnchor.constraint(equalToConstant: 46),
            expandButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    @objc func backButtonTapped() {
        coordinator?.popCurrentViewController()
    }
    
    @objc func expandButtonTapped() {
        coordinator?.showPicture(viewModel.workImageName)
    }
}
