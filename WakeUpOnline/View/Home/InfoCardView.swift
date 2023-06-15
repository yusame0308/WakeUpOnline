//
//  InfoCardView.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/08.
//

import UIKit
import SnapKit

final class InfoCardView: UIView {

    private let iconImageView: UIImageView = {
        let imageWidth: CGFloat = 50
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageWidth * 0.5
        imageView.clipsToBounds = true
        // 正方形にリサイズ
        imageView.image = R.image.skiParking()?.cropResizedSquare(imageWidth)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupLayout()
    }

    private func setupLayout() {
        self.backgroundColor = .lightBrown
        self.addSubview(iconImageView)

        self.snp.makeConstraints { make in
            make.height.equalTo(100)
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
