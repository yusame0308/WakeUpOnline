//
//  UserDetailViewController.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/20.
//

import UIKit

final class UserDetailViewController: UIViewController {

    private let user: User

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
    private lazy var dailyRecordView = DailyRecordView(width: view.bounds.width - 40, recordText: user.wakeUpLog.recordText)

    init(user: User) {
        self.user = user

        super.init(nibName: nil, bundle: nil)

        timeLabel.text = user.wakeUpTimeList.stringValues(of: Date.weekdayInt).time
        userNameLabel.attributedText = user.name.attributedStringWithLineHeightMultiple(by: 0.85, isCentered: true)
        messageLabel.attributedText = user.message.attributedStringWithLineHeightMultiple(by: 0.85, isCentered: true)
        iconImageView.setIconImage(with: URL(string: user.iconUrl), width: UserDetailViewController.iconWidth)
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
        // プロフィールのStackView
        let profileStackView = UIStackView(arrangedSubviews: [iconImageView, userNameLabel, messageLabel])
        profileStackView.axis = .vertical
        profileStackView.alignment = .center
        profileStackView.spacing = 10
        // プロフィールView
        let profileView = profileStackView.withMargin(top: 15, left: 30, bottom: 15, right: 30)
        profileView.addShadow()

        // 全体のStackView
        let baseStackView = UIStackView(arrangedSubviews: [timeLabel, SpacerView(), profileView, dailyRecordView])
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.spacing = 20

        view.addSubview(baseStackView)

        baseStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }

        profileView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(baseStackView)
        }

        dailyRecordView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(baseStackView)
        }
    }

}
