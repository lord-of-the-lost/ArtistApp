//
//  DataEntities.swift
//  ArtApp
//
//  Created by Николай Игнатов on 29.01.2025.
//

struct ArtistsList: Decodable {
    let artists: [Artist]
}

struct Artist: Decodable {
    let name: String
    let bio: String
    let image: String
    let works: [Work]
}

struct Work: Decodable {
    let title: String
    let image: String
    let info: String
}
