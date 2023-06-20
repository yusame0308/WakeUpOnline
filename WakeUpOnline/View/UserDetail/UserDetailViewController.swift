//
//  UserDetailViewController.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/20.
//

import UIKit

class UserDetailViewController: UIViewController {

    // アイコンの大きさ
    static let iconWidth: CGFloat = 100

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

    // 達成記録
    private let recordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .accentBrown
        label.numberOfLines = 2
        return label
    }()

    init(wakeUpInfo: WakeUpInfo) {
        super.init(nibName: nil, bundle: nil)

        timeLabel.text = wakeUpInfo.timeText
        userNameLabel.text = wakeUpInfo.userName
        messageLabel.text = wakeUpInfo.message
        recordLabel.text = wakeUpInfo.recordText
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
        let baseStackView = UIStackView(arrangedSubviews: [timeLabel, iconImageView, userNameLabel, messageLabel, recordLabel])
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .equalSpacing

        view.addSubview(baseStackView)

        baseStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
