//
//  ProfileEditViewController.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/03.
//

import UIKit

final class ProfileEditViewController: UIViewController {

    // アイコンの大きさ
    private static let iconWidth: CGFloat = 100

    // アイコン
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        // 画像を正方形にリサイズ
        imageView.image = R.image.testImage1()?.cropResizedSquare(iconWidth)
        imageView.layer.cornerRadius = iconWidth * 0.5
        imageView.clipsToBounds = true
        return imageView
    }()

    // 名前のテキストフィールド
    private let userNameTextField = EditTextField(placeholder: "名前", textColor: .blackBrown, fontSize: 18)

    // メッセージのテキストフィールド
    private let messageTextField = EditTextField(placeholder: "メッセージ", textColor: .grayBrown, fontSize: 16)

    init(wakeUpInfo: WakeUpInfo) {
        userNameTextField.text = wakeUpInfo.userName
        messageTextField.text = wakeUpInfo.message

        super.init(nibName: nil, bundle: nil)
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
        let baseStackView = UIStackView(arrangedSubviews: [iconImageView, userNameTextField, messageTextField])
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.spacing = 20

        view.addSubview(baseStackView)

        baseStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }

        let textFieldHeight: CGFloat = 40

        userNameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(baseStackView)
            make.height.equalTo(textFieldHeight)
        }

        messageTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(baseStackView)
            make.height.equalTo(textFieldHeight)
        }
    }

}
