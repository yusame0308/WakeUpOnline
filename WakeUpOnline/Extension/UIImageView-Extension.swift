//
//  UIImageView-Extension.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/28.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setIconImage(with url: URL?, width: CGFloat) {
        let placeHolderImage = R.image.placeholder()?.cropResizedSquare(width)
        self.kf.setImage(with: url, placeholder: placeHolderImage) { result in
            switch result {
            case .success(let imageResult):
                self.image = imageResult.image.cropResizedSquare(width)
            case .failure(let err):
                debugPrint(err)
            }
        }
    }
}
