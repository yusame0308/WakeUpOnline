//
//  TimeCollectionViewCell.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/02.
//

import UIKit

final class TimeCollectionViewCell: UICollectionViewCell {

    // 曜日
    private let weekDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .grayBrown
        return label
    }()

    // 起床時間
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .blackBrown
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        let baseStackView = UIStackView(arrangedSubviews: [weekDayLabel, timeLabel])
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.spacing = 5

        contentView.addSubview(baseStackView)

        baseStackView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView)
        }
    }

    // CollectionViewから呼ばれる
    func render(with timeInfo: (weekDay: String, time: String)) {
        weekDayLabel.text = timeInfo.weekDay
        timeLabel.attributedText = timeInfo.time.attributedStringWithKern(-0.5)
    }

}
