//
//  UIView-Extension.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/22.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.blackBrown.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.4
        self.layer.cornerRadius = 5
    }
}
