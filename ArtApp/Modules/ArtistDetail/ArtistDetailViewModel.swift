//
//  ArtistDetailViewModel.swift
//  ArtApp
//
//  Created by Николай Игнатов on 30.01.2025.
//

import UIKit

final class ArtistDetailViewModel {
    let artistName: String
    let artistBio: String
    let artistImageName: String
    let works: [Work]
    
    init(artist: Artist) {
        self.artistName = artist.name
        self.artistBio = artist.bio
        self.artistImageName = artist.image
        self.works = artist.works
    }
    
    func getArtistImage() -> UIImage? {
        UIImage(named: artistImageName) ?? UIImage(systemName: "person.fill")
    }
}

