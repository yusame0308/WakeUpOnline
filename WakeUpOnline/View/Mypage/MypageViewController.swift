//
//  MypageViewController.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/08.
//

import UIKit
import FirebaseAuth

final class MypageViewController: UIViewController {

    private var wakeUpInfo: WakeUpInfo! {
        didSet {
            userNameLabel.attributedText = wakeUpInfo.userName.attributedStringWithLineHeightMultiple(by: 0.85, isCentered: true)
            messageLabel.attributedText = wakeUpInfo.message.attributedStringWithLineHeightMultiple(by: 0.85, isCentered: true)
        }
    }

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

    // プロフィール
    private var profileView = UIView()

    // デイリーレコード
    private lazy var dailyRecordView = DailyRecordView(width: view.bounds.width - 40, recordText: wakeUpInfo.recordText)

    // 起床時間リスト
    private lazy var timeListView = TimeListView(width: view.bounds.width - 40, timeList: testTimeList)

    override func viewDidLoad() {
        super.viewDidLoad()
        wakeUpInfo = wakeUpInfos[0]

        view.backgroundColor = .white

        setupLayout()
        setupGesture()
    }

    private func setupLayout() {
        // プロフィールのStackView
        let profileStackView = UIStackView(arrangedSubviews: [iconImageView, userNameLabel, messageLabel])
        profileStackView.axis = .vertical
        profileStackView.alignment = .center
        profileStackView.spacing = 10
        // プロフィールView
        profileView = profileStackView.withMargin(top: 15, left: 30, bottom: 15, right: 30)
        profileView.addShadow()

        // 全体のStackView
        let baseStackView = UIStackView(arrangedSubviews: [profileView, dailyRecordView, timeListView])
        baseStackView.axis = .vertical
        baseStackView.alignment = .fill
        baseStackView.spacing = 20

        view.addSubview(baseStackView)

        baseStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }

    // ViewにGestureを設定
    private func setupGesture() {
        // プロフィール
        let profileViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showProfileEditView))
        profileView.addGestureRecognizer(profileViewTapGestureRecognizer)
        // 起床時間リスト
        let timeListViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showTimeListEditView))
        timeListView.addGestureRecognizer(timeListViewTapGestureRecognizer)
    }

    // プロフィール編集画面を表示
    @objc func showProfileEditView() {
        let profileEditViewController = ProfileEditViewController(wakeUpInfo: wakeUpInfo)
        profileEditViewController.delegate = self
        // ハーフモーダルに設定
        if let sheet = profileEditViewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(profileEditViewController, animated: true)
    }

    // 起床時間リスト編集画面を表示
    @objc func showTimeListEditView() {
        let timeListEditViewController = TimeListEditViewController(timeList: testTimeList)
        timeListEditViewController.delegate = self
        // ハーフモーダルに設定
        if let sheet = timeListEditViewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(timeListEditViewController, animated: true)
    }

}

extension MypageViewController: ProfileEditViewControllerDelegate {

    // プロフィール保存ボタンの処理
    func saveButtonDidPressed(userName: String, message: String, iconImage: UIImage?) async throws {
        userNameLabel.text = userName
        messageLabel.text = message
        iconImageView.image = iconImage

        // FirebaseAuthのプロフィール更新
        guard let user = Auth.auth().currentUser else { return }
        let request = user.createProfileChangeRequest()
        request.displayName = userName
//        request.photoURL = photoURL

        do {
            try await request.commitChanges()
        } catch {
            throw error
        }
    }

}

extension MypageViewController: TimeListEditViewControllerDelegate {

    // 起床時間リスト保存ボタンの処理
    func saveButtonDidPressed(timeList: TimeList) {
        // リファクタリングする
        timeListView.timeList = timeList
        timeListView.timeCollectionView.reloadData()
    }

}
