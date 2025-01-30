//
//  ArtistListViewController.swift
//  ArtApp
//
//  Created by Николай Игнатов on 28.01.2025.
//

import UIKit

final class ArtistListViewController: UIViewController {
    private let viewModel: ArtistListViewModel
    private weak var coordinator: AppCoordinator?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 1
        label.text = "Artists"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var artistsCollectionView: UICollectionView = {
        let itemWidth = UIScreen.main.bounds.width - 40
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemWidth, height: 96)
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ArtistCell.self, forCellWithReuseIdentifier: "ArtistCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    init(viewModel: ArtistListViewModel, coordinator: AppCoordinator) {
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
        bindViewModel()
    }
}

// MARK: - UITableViewDataSource
extension ArtistListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfArtists()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCell", for: indexPath) as? ArtistCell else {
            return UICollectionViewCell() }
        
        let cellViewModel = viewModel.getArtistCellViewModel(at: indexPath.row)
        cell.configure(with: cellViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ArtistListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let artist = viewModel.getArtist(at: indexPath.row) else { return }
        coordinator?.showArtistDetail(artist)
    }
}

// MARK: - UISearchBarDelegate
extension ArtistListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        viewModel.filterArtists(by: searchText)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterArtists(by: searchText)
        
        if searchText.isEmpty {
            searchBar.resignFirstResponder()
        }
    }
}

// MARK: - Private Methods
private extension ArtistListViewController {
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(artistsCollectionView)
    }
    
    func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.artistsCollectionView.reloadData()
            }
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            artistsCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            artistsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            artistsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            artistsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
