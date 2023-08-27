//
//  LoadingIndicator.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/08/27.
//

import UIKit

final class LoadingIndicator: UIActivityIndicatorView {

    init() {
        super.init(frame: .zero)

        style = .medium
        color = .white
        backgroundColor = .systemGray
        layer.cornerRadius = 5.0
        layer.opacity = 0.7
        isHidden = true

        snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // アニメーション・操作の可否を設定
    func setIsLoading(_ isLoading: Bool) {
        isHidden = !isLoading

        if let superview = superview {
            superview.isUserInteractionEnabled = !isLoading
        }

        if isLoading {
            startAnimating()
        } else {
            stopAnimating()
        }
    }

}
