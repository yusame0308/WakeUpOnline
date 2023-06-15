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
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkBrown
        return label
    }()

    private let infoCardView = InfoCardView()

    func render(with wakeUpInfo: WakeUpInfo) {
        timeLabel.text = wakeUpInfo.timeText
        setupLayout()
    }

    private func setupLayout() {
        let baseStackView = UIStackView(arrangedSubviews: [timeLabel, infoCardView])
        baseStackView.axis = .horizontal
        baseStackView.alignment = .top
        baseStackView.distribution = .fill

        contentView.addSubview(baseStackView)

        baseStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.left.equalTo(contentView).offset(20)
            make.bottom.equalTo(contentView).offset(-20)
            make.right.equalTo(contentView).offset(-20)
        }

        timeLabel.snp.makeConstraints { make in
            make.width.equalTo(70)
        }
    }

}
