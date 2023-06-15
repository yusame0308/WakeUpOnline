//
//  UIImage-Extension.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/12.
//

import UIKit.UIImage

extension UIImage {
    // 正方形にリサイズ
    func cropResizedSquare(_ resizeWidth: CGFloat) -> UIImage? {
        let minSide = min(size.width, size.height)
        let ratio = resizeWidth / minSide

        let origin = size.width > size.height
        ? CGPoint(x: (minSide - size.width) * 0.5 * ratio, y: 0.0)
        : CGPoint(x: 0.0, y: (minSide - size.height) * 0.5 * ratio)

        UIGraphicsBeginImageContextWithOptions(CGSize(width: resizeWidth, height: resizeWidth), false, 0.0)
        draw(in: CGRect(origin: origin, size: CGSize(width: size.width * ratio, height: size.height * ratio)))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage
    }
}
