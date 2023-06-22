//
//  UserDetailViewController.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/20.
//

import UIKit

final class UserDetailViewController: UIViewController {

    private let wakeUpInfo: WakeUpInfo

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
        imageView.image = R.image.skiParking()?.cropResizedSquare(iconWidth)
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

    init(wakeUpInfo: WakeUpInfo) {
        self.wakeUpInfo = wakeUpInfo

        super.init(nibName: nil, bundle: nil)

        timeLabel.text = wakeUpInfo.timeText
        userNameLabel.text = wakeUpInfo.userName
        messageLabel.text = wakeUpInfo.message
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupLayout()
    }

    private func setupLayout() {
        // 全体のStackView
        let baseStackView = UIStackView(arrangedSubviews: [timeLabel, iconImageView, userNameLabel, messageLabel, dailyRecordView])
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .equalSpacing

        view.addSubview(baseStackView)

        baseStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }

        dailyRecordView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(baseStackView)
        }
    }

}
