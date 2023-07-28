//
//  UIImageView-Extension.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/28.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setIconImage(with url: URL?) {
        let placeHolderImage = R.image.placeholder()?.cropResizedSquare(100)
        self.kf.setImage(with: url, placeholder: placeHolderImage) { result in
            switch result {
            case .success(let imageResult):
                self.image = imageResult.image.cropResizedSquare(100)
            case .failure(let err):
                print(err)
            }
        }
    }
}
