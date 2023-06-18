//
//  HomeTableViewCell.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/08.
//

import UIKit
import SnapKit

final class HomeTableViewCell: UITableViewCell {

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .blackBrown
        return label
    }()

    private let infoCardView = InfoCardView()

    // TableViewから呼ばれる
    func render(with wakeUpInfo: WakeUpInfo) {
        timeLabel.text = wakeUpInfo.timeText
        infoCardView.setupTexts(with: wakeUpInfo)
        setupLayout()
    }

    private func setupLayout() {
        let baseStackView = UIStackView(arrangedSubviews: [timeLabel, infoCardView])
        baseStackView.axis = .horizontal
        baseStackView.alignment = .top
        baseStackView.distribution = .fill

        contentView.addSubview(baseStackView)

        baseStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(20)
            make.bottom.equalTo(contentView).offset(-10)
            make.right.equalTo(contentView).offset(-20)
        }

        timeLabel.snp.makeConstraints { make in
            make.width.equalTo(65)
        }
    }

}
