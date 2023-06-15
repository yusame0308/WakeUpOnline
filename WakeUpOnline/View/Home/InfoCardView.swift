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
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.image = R.image.skiParking()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }

    private func setupLayout() {
        self.addSubview(iconImageView)

        iconImageView.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.center.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
