//
//  MypageViewController.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/08.
//

import UIKit
import Combine

final class MypageViewController: UIViewController {

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

    // プロフィール
    private var profileView = UIView()

    // デイリーレコード
    private lazy var dailyRecordView = DailyRecordView(width: view.bounds.width - 40)

    // 起床時間リスト
    private lazy var timeListView = TimeListView(width: view.bounds.width - 40)

    // アイコンの大きさ
    private static let iconWidth: CGFloat = 100

    // ViewModel
    private let viewModel: MypageViewModelProtocol = MypageViewModel()
    private var cancellables = Set<AnyCancellable>()

    // Subject
    private var viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private var profileViewTappedSubject = PassthroughSubject<Void, Never>()
    private var timeListViewTappedSubject = PassthroughSubject<Void, Never>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        timeListView.timeCollectionView.allowsSelection = false

        setupLayout()
        setupGesture()
        bind()

        viewDidLoadSubject.send()
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

    private func bind() {
        let output = viewModel.transform(
            input: .init(
                viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(),
                profileViewTapped: profileViewTappedSubject.eraseToAnyPublisher(),
                timeListViewTapped: timeListViewTappedSubject.eraseToAnyPublisher()
            ),
            subscriptions: &cancellables
        )

        output
            .currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.updateViews(with: user)
            }
            .store(in: &cancellables)

        output
            .presentProfileEditView
            .receive(on: DispatchQueue.main)
            .sink { user in
                print("Bind, onPresentProfileEditView")
                print(user)
            }
            .store(in: &cancellables)

        output
            .presentTimeListEditView
            .receive(on: DispatchQueue.main)
            .sink { user in
                print("Bind, onPresentTimeListEditView")
                print(user)
            }
            .store(in: &cancellables)

        output
            .showErrorAlert
            .receive(on: DispatchQueue.main)
            .sink { message in
                print("Bind, onShowErrorAlert")
                print(message)
            }
            .store(in: &cancellables)
    }

    private func updateViews(with user: User) {
        userNameLabel.attributedText = user.name.attributedStringWithLineHeightMultiple(by: 0.85, isCentered: true)
        messageLabel.attributedText = user.message.attributedStringWithLineHeightMultiple(by: 0.85, isCentered: true)
        iconImageView.setIconImage(with: URL(string: user.iconUrl), width: MypageViewController.iconWidth)
        dailyRecordView.setRecordText(user.wakeUpLog.recordText)
        timeListView.setTimeList(user.wakeUpTimeList)
    }

    // プロフィール編集画面を表示
    @objc func showProfileEditView() {
        profileViewTappedSubject.send()
//        let profileEditViewController = ProfileEditViewController(user: user)
//        profileEditViewController.delegate = self
//        // ハーフモーダルに設定
//        if let sheet = profileEditViewController.sheetPresentationController {
//            sheet.detents = [.medium()]
//        }
//        present(profileEditViewController, animated: true)
    }

    // 起床時間リスト編集画面を表示
    @objc func showTimeListEditView() {
        timeListViewTappedSubject.send()
//        let timeListEditViewController = TimeListEditViewController(timeList: user.wakeUpTimeList)
//        timeListEditViewController.delegate = self
//        // ハーフモーダルに設定
//        if let sheet = timeListEditViewController.sheetPresentationController {
//            sheet.detents = [.medium()]
//        }
//        present(timeListEditViewController, animated: true)
    }

}

extension MypageViewController: ProfileEditViewControllerDelegate {

    // プロフィール保存ボタンの処理
    func saveButtonDidPressed(userName: String, message: String, iconImage: UIImage?) async throws {
        userNameLabel.text = userName
        messageLabel.text = message
        iconImageView.image = iconImage

        // FirebaseAuthのプロフィール更新
//        guard let user = Auth.auth().currentUser else { return }
//        try await FirestoreCollectionRef.users.document(user.uid).updateData([
//            "name": userName,
//            "message": message,
//            "icon_url": ""
//        ])
    }

}

extension MypageViewController: TimeListEditViewControllerDelegate {

    // 起床時間リスト保存ボタンの処理
    func saveButtonDidPressed(timeList: WakeUpTimeList) {
        // リファクタリングする
//        timeListView.timeList = timeList
//        timeListView.timeCollectionView.reloadData()
    }

}
