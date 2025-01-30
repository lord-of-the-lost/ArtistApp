//
//  ArtistListViewModel.swift
//  ArtApp
//
//  Created by Николай Игнатов on 29.01.2025.
//

import UIKit

final class ArtistListViewModel {
    var onUpdate: (() -> Void)?
    
    private var allArtists: [Artist] = []
    private var filteredArtists: [Artist] = [] {
        didSet {
            onUpdate?()
        }
    }
   
    init() {
        loadMockData()
    }

    func filterArtists(by searchText: String) {
        if searchText.isEmpty {
            filteredArtists = allArtists
        } else {
            filteredArtists = allArtists.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func getArtistCellViewModel(at index: Int) -> ArtistCell.ArtistCellViewModel {
        let artist = filteredArtists[index]
        return ArtistCell.ArtistCellViewModel(
            artistImage: UIImage(named: artist.image),
            artistName: artist.name,
            artistDescription: artist.bio
        )
    }
    
    func getArtist(at index: Int) -> Artist? {
        guard index >= 0 && index < filteredArtists.count else { return nil }
        return filteredArtists[index]
    }
    
    func numberOfArtists() -> Int {
        filteredArtists.count
    }
}

// MARK: - Private Methods
private extension ArtistListViewModel {
    func loadMockData() {
        do {
            let data = try loadLocalJSONFile(named: "MockData")
            let artists = try decodeArtists(from: data)
            updateArtists(with: artists)
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadLocalJSONFile(named filename: String) throws -> Data {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw DataLoadingError.fileNotFound
        }
        return try Data(contentsOf: url)
    }

    func decodeArtists(from data: Data) throws -> [Artist] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(ArtistsList.self, from: data)
        return response.artists
    }

    func updateArtists(with artists: [Artist]) {
        allArtists = artists
        filteredArtists = artists
    }
    
    enum DataLoadingError: Error {
        case fileNotFound
    }
}
