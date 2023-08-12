//
//  InfoCardView.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/08.
//

import UIKit
import SnapKit

final class InfoCardView: UIView {

    // アイコンの大きさ
    private static let iconWidth: CGFloat = 50

    // アイコン
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        // 画像を正方形にリサイズ
        let image = Bool.random() ? R.image.placeholder() : R.image.testImage2()
        imageView.image = image?.cropResizedSquare(iconWidth)
        imageView.layer.cornerRadius = iconWidth * 0.5
        imageView.clipsToBounds = true
        return imageView
    }()

    // 名前
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .blackBrown
        label.numberOfLines = 2
        label.lineBreakMode = .byClipping
        return label
    }()

    // メッセージ
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .grayBrown
        label.numberOfLines = 2
        return label
    }()

    // 達成記録
    private let recordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .accentBrown
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        self.addShadow()

        setupLayout()
    }

    private func setupLayout() {
        let nameStackView = UIStackView(arrangedSubviews: [userNameLabel, messageLabel])
        nameStackView.axis = .vertical
        nameStackView.alignment = .leading
        nameStackView.spacing = 3
        // 右側にスペースを追加
        nameStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        nameStackView.isLayoutMarginsRelativeArrangement = true

        let baseStackView = UIStackView(arrangedSubviews: [iconImageView, nameStackView, recordLabel])
        baseStackView.axis = .horizontal
        baseStackView.alignment = .center
        baseStackView.spacing = 10

        self.addSubview(baseStackView)

        baseStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-15)
            make.right.equalToSuperview()
        }

        // アイコンのwidth
        iconImageView.snp.makeConstraints { make in
            make.width.equalTo(InfoCardView.iconWidth)
        }

        // 達成記録のwidth
        recordLabel.snp.makeConstraints { make in
            make.width.equalTo(65)
        }
    }

    // Labelに文字を表示
    func setupTexts(with user: User) {
        userNameLabel.attributedText = user.name.attributedStringWithLineHeightMultiple(by: 0.85)
        messageLabel.attributedText = user.message.attributedStringWithLineHeightMultiple(by: 0.85)
        recordLabel.attributedText = user.wakeUpLog.recordText.attributedStringWithKern(1)
        iconImageView.setIconImage(with: URL(string: user.iconUrl), width: InfoCardView.iconWidth)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
