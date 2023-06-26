//
//  MypageViewController.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/08.
//

import UIKit

final class MypageViewController: UIViewController {

    private var wakeUpInfo: WakeUpInfo = wakeUpInfos[0] {
        didSet {
            timeLabel.text = wakeUpInfo.timeText
            userNameLabel.attributedText = wakeUpInfo.userName.attributedStringWithLineHeightMultiple(by: 0.85)
            messageLabel.attributedText = wakeUpInfo.message.attributedStringWithLineHeightMultiple(by: 0.85)
        }
    }

    // アイコンの大きさ
    private static let iconWidth: CGFloat = 100

    // 起床時間
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        label.textColor = .blackBrown
        return label
    }()

    // アイコン
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        // 画像を正方形にリサイズ
        imageView.image = R.image.testImage1()?.cropResizedSquare(iconWidth)
        imageView.layer.cornerRadius = iconWidth * 0.5
        imageView.clipsToBounds = true
        return imageView
    }()

    // 名前
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .blackBrown
        label.numberOfLines = 2
        label.lineBreakMode = .byClipping
        return label
    }()

    // メッセージ
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .grayBrown
        label.numberOfLines = 2
        return label
    }()

    // デイリーレコード
    private lazy var dailyRecordView = DailyRecordView(viewWidth: view.bounds.width, recordText: wakeUpInfo.recordText)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupLayout()
    }

    private func setupLayout() {
        // 全体のStackView
        let baseStackView = UIStackView(arrangedSubviews: [iconImageView, userNameLabel, messageLabel, dailyRecordView, timeLabel])
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .equalSpacing

        view.addSubview(baseStackView)

        baseStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }

        dailyRecordView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(baseStackView)
        }
    }

}
