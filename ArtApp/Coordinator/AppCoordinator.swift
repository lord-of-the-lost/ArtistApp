//
//  AppCoordinator.swift
//  ArtApp
//
//  Created by Николай Игнатов on 30.01.2025.
//

import UIKit

final class AppCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        let viewModel = ArtistListViewModel()
        let artistListViewController = ArtistListViewController(viewModel: viewModel, coordinator: self)
        navigationController.setViewControllers([artistListViewController], animated: false)
    }
    
    func showArtistDetail(_ artist: Artist) {
        let viewModel = ArtistDetailViewModel(artist: artist)
        let detailViewController = ArtistDetailViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func showPictureDetail(_ work: Work) {
        let viewModel = PictureDetailViewModel(work: work)
        let detailViewController = PictureDetailViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func popCurrentViewController() {
        navigationController.popViewController(animated: true)
    }
}
