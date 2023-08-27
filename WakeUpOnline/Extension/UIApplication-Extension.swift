//
//  UIApplication-Extension.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/08/27.
//

import UIKit

extension UIApplication {
    static var topViewController: UIViewController? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .filter { $0.isKeyWindow }
            .first?
            .rootViewController
    }
}
