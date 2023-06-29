//
//  UIView-Extension.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/22.
//

import UIKit

extension UIView {
    // 自身に影を追加
    func addShadow() {
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.blackBrown.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.4
        self.layer.cornerRadius = 5
    }

    // 自身にmarginを追加
    func withMargin(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> UIView {
        let view = UIView()
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(top)
            make.left.equalToSuperview().offset(left)
            make.bottom.equalToSuperview().offset(-bottom)
            make.right.equalToSuperview().offset(-right)
        }
        return view
    }
}
