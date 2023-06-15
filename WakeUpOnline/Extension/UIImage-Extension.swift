//
//  UIImage-Extension.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/12.
//

import UIKit.UIImage

extension UIImage {
    func resize(size newSize: CGSize) -> UIImage? {
        let widthRatio = newSize.width / size.width
        let heightRatio = newSize.height / size.height
        let ratio = widthRatio < heightRatio ? widthRatio : heightRatio

        let resizeSize = CGSize(width: size.width * ratio, height: size.height * ratio)

        UIGraphicsBeginImageContextWithOptions(resizeSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: resizeSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage
    }
}
