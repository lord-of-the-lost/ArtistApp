//
//  PictureViewModel.swift
//  ArtApp
//
//  Created by Николай Игнатов on 31.01.2025.
//

import UIKit

final class PictureViewModel {
    let pictureName: String
    let minZoomScale: CGFloat = 1.0
    let maxZoomScale: CGFloat = 6.0
    
    init(pictureName: String) {
        self.pictureName = pictureName
    }
    
    func getImage() -> UIImage? {
        UIImage(named: pictureName) ?? UIImage(systemName: "person.fill")
    }
    
    func calculateZoomRect(for scale: CGFloat, center: CGPoint, imageSize: CGSize) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.width = imageSize.width / scale
        zoomRect.size.height = imageSize.height / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
}
