//
//  DailyRecordView.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/22.
//

import UIKit

final class DailyRecordView: UIView {

    // アイテムの幅
    private let itemWidth: CGFloat

    // デイリーログ
    private let dailyLogCollectionView: DailyLogCollectionView

    // 達成記録ラベル
    private let recordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .accentBrown
        label.numberOfLines = 2
        return label
    }()

    // 達成記録
    private lazy var recordLabelItem: UIView = {
        let view = UIView()
        view.addSubview(recordLabel)
        recordLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        view.snp.makeConstraints { make in
            make.width.equalTo(itemWidth)
        }
        return view
    }()

    init(width: CGFloat) {
        itemWidth = width / 2 - 30
        dailyLogCollectionView = DailyLogCollectionView(width: itemWidth)

        super.init(frame: .zero)

        setupLayout()

        self.addShadow()
    }

    private func setupLayout() {
        // 全体のStackView
        let baseStackView = UIStackView(arrangedSubviews: [dailyLogCollectionView, recordLabelItem])
        baseStackView.axis = .horizontal
        baseStackView.distribution = .equalSpacing

        self.addSubview(baseStackView)

        baseStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-15)
        }

        // 区切り線
        let divider = UIView()
        divider.backgroundColor = .blackBrown.withAlphaComponent(0.2)

        self.addSubview(divider)

        divider.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(baseStackView)
            make.center.equalToSuperview()
        }
    }

    func setRecordText(_ text: String) {
        recordLabel.attributedText = text.attributedStringWithKern(1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
