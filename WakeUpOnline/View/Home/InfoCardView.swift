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
        // 画像を正方形にリサイズ
        imageView.image = R.image.skiParking()?.cropResizedSquare(imageWidth)
        imageView.layer.cornerRadius = imageWidth * 0.5
        imageView.clipsToBounds = true
        return imageView
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let recordLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.blackBrown.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.4
        self.layer.cornerRadius = 5

        setupLayout()
    }

    private func setupLayout() {
        self.addSubview(iconImageView)

        self.snp.makeConstraints { make in
            make.height.equalTo(70)
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func setupTexts(by wakeUpInfo: WakeUpInfo) {
        userNameLabel.text = wakeUpInfo.userName
        messageLabel.text = wakeUpInfo.message
        recordLabel.text = wakeUpInfo.recordText
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
