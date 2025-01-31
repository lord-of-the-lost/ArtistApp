//
//  PictureDetailViewModel.swift
//  ArtApp
//
//  Created by Николай Игнатов on 31.01.2025.
//


import UIKit

final class PictureDetailViewModel {
    let workImageName: String
    let pictureName: String
    let pictureDescription: String
    
    init(work: Work) {
        self.workImageName = work.image
        self.pictureName = work.title
        self.pictureDescription = work.info
    }
    
    func getPictureImage() -> UIImage? {
        UIImage(named: workImageName) ?? UIImage(systemName: "person.fill")
    }
}
