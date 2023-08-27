//
//  ProfileEditViewController.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/03.
//

import UIKit
import PhotosUI

protocol ProfileEditViewControllerDelegate: AnyObject {
    func saveButtonDidPressed(userName: String, message: String, iconImage: UIImage?) async throws
}

final class ProfileEditViewController: UIViewController {

    weak var delegate: ProfileEditViewControllerDelegate?
    let input: ProfileEditInput

    // アイコンの大きさ
    private static let iconWidth: CGFloat = 100
    private static let editImageWidth: CGFloat = 25

    // タイトルラベル
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "プロフィールを編集"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .blackBrown
        return label
    }()

    // アイコンボタン
    private let iconButton: UIButton = {
        // 画像をセット
        var config = UIButton.Configuration.plain()
        config.image = R.image.testImage1()?.cropResizedSquare(iconWidth)
        config.contentInsets = .zero
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = iconWidth * 0.5
        button.clipsToBounds = true
        return button
    }()

    // 編集マーク
    private let editImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "pencil.circle.fill")?.withConfiguration(UIImage.SymbolConfiguration(weight: .bold)))
        imageView.tintColor = .blackBrown
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = editImageWidth * 0.5
        return imageView
    }()

    // 名前のテキストフィールド
    private let userNameTextField = EditTextField(placeholder: "名前", textColor: .blackBrown, fontSize: 18)

    // メッセージのテキストフィールド
    private let messageTextField = EditTextField(placeholder: "メッセージ", textColor: .grayBrown, fontSize: 16)

    // 保存ボタン
    private let saveButton = SaveButton()

    init(user: User, input: ProfileEditInput) {
        userNameTextField.text = user.name
        messageTextField.text = user.message
        self.input = input

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupLayout()
        setupAction()
    }

    private func setupLayout() {
        // プロフィールのStackView
        let baseStackView = UIStackView(arrangedSubviews: [titleLabel, SpacerView(height: 10), iconButton, userNameTextField, messageTextField, SpacerView(), saveButton])
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.spacing = 15

        view.addSubview(baseStackView)

        baseStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
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

        // アイコンの編集マーク
        view.addSubview(editImageView)
        editImageView.snp.makeConstraints { make in
            make.top.equalTo(iconButton).offset(4)
            make.right.equalTo(iconButton).offset(-4)
            make.size.equalTo(CGSize(width: ProfileEditViewController.editImageWidth, height: ProfileEditViewController.editImageWidth))
        }
    }

    private func setupAction() {
        iconButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.showPhotoPicker()
        }, for: .primaryActionTriggered)

        saveButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.saveProfile()
        }, for: .primaryActionTriggered)
    }

    // 画像選択画面を表示
    private func showPhotoPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }

    // 保存ボタンの処理
    private func saveProfile() {
        Task {
            do {
                // リファクタリング
                input.profileSaveButtonTapped.send(UserUpdate(name: "send", message: "send", iconImage: nil))
//                try await delegate?.saveButtonDidPressed(userName: userNameTextField.text ?? "", message: messageTextField.text ?? "", iconImage: iconButton.imageView?.image)
//                try await FirestoreClient().uploadIconImage(data: iconButton.currentImage!.jpegData(compressionQuality: 1)!)
                self.dismiss(animated: true)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}

extension ProfileEditViewController: PHPickerViewControllerDelegate {

    // 画像選択後の処理
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let itemProvider = results.first?.itemProvider else {
            picker.dismiss(animated: true)
            return
        }

        // 画像をアイコンボタンにセット
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                if let error = error {
                    print(error)
                    return
                }

                guard let image = image as? UIImage else {
                    return
                }

                DispatchQueue.main.async {
                    self?.iconButton.setImage(image.cropResizedSquare(ProfileEditViewController.iconWidth), for: .normal)
                }
            }
        }

        picker.dismiss(animated: true)
    }

}
