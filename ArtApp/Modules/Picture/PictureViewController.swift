//
//  PictureViewController.swift
//  ArtApp
//
//  Created by Николай Игнатов on 31.01.2025.
//

import UIKit

final class PictureViewController: UIViewController {
    private weak var coordinator: AppCoordinator?
    private let viewModel: PictureViewModel
    private var isButtonHidden = false
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.minimumZoomScale = viewModel.minZoomScale
        scrollView.maximumZoomScale = viewModel.maxZoomScale
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "closeCircle"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: PictureViewModel, coordinator: AppCoordinator) {
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
        setupGestures()
    }
}

// MARK: - UIScrollViewDelegate
extension PictureViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}

// MARK: - Private Methods
private extension PictureViewController {
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(backButton)
        scrollView.addSubview(imageView)
    }
    
    func configureView() {
        imageView.image = viewModel.getImage()
    }
    
    func setupGestures() {
        let singleTap = UITapGestureRecognizer(
            target: self,
            action: #selector(handleSingleTap)
        )
        singleTap.numberOfTapsRequired = 1
        
        let doubleTap = UITapGestureRecognizer(
            target: self,
            action: #selector(handleDoubleTap)
        )
        doubleTap.numberOfTapsRequired = 2
        singleTap.require(toFail: doubleTap)
        
        scrollView.addGestureRecognizer(singleTap)
        scrollView.addGestureRecognizer(doubleTap)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func handleSingleTap() {
        UIView.animate(withDuration: 0.3) {
            self.backButton.alpha = self.isButtonHidden ? 1.0 : 0.0
            self.isButtonHidden.toggle()
        }
    }
    
    @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == viewModel.minZoomScale {
            let zoomRect = viewModel.calculateZoomRect(
                for: viewModel.maxZoomScale,
                center: recognizer.location(in: imageView),
                imageSize: imageView.bounds.size
            )
            scrollView.zoom(to: zoomRect, animated: true)
        } else {
            scrollView.setZoomScale(viewModel.minZoomScale, animated: true)
        }
    }
    
    @objc func backButtonTapped() {
        coordinator?.popCurrentViewController()
    }
}
