//
//  TimeListEditViewController.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/03.
//

import UIKit

protocol TimeListEditViewControllerDelegate: AnyObject {
    func saveButtonDidPressed(timeList: WakeUpTimeList)
}

final class TimeListEditViewController: UIViewController {

    weak var delegate: TimeListEditViewControllerDelegate?

    private var timeList: WakeUpTimeList

    // 選択中のセル番号
    private var selectedCellIndex = 0 {
        didSet {
            // ピッカーに選択された時間を表示
            timePicker.date = timeList.dateValue(of: selectedCellIndex + 1)
        }
    }

    // タイトルラベル
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "起床時間を編集"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .blackBrown
        return label
    }()

    // 起床時間リスト
    private lazy var timeListView = TimeListView(width: view.bounds.width - 40)

    // 時間ピッカー
    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.locale = Locale(identifier: "ja_JP")
        picker.timeZone = TimeZone(identifier: "Asia/Tokyo")
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        // 選択できる時間の範囲を指定
        let (startDate, endDate) = Date.availableDateRange
        picker.minimumDate = startDate
        picker.maximumDate = endDate
        return picker
    }()

    // 保存ボタン
    private let saveButton = SaveButton()

    init(timeList: WakeUpTimeList) {
        self.timeList = timeList

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        timeListView.setTimeList(timeList)
        // セルを選択状態にする
        timeListView.timeCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        timeListView.timeCollectionView.delegate = self
        selectedCellIndex = 0

        setupLayout()
        setupAction()
    }

    private func setupLayout() {
        // プロフィールのStackView
        let baseStackView = UIStackView(arrangedSubviews: [titleLabel, SpacerView(), timeListView, timePicker, saveButton])
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.spacing = 30

        view.addSubview(baseStackView)

        baseStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }

        timeListView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(baseStackView)
        }

        timePicker.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 250, height: 140))
        }
    }

    private func setupAction() {
        saveButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.saveTimeList()
        }, for: .primaryActionTriggered)
    }

    // 保存ボタンの処理
    private func saveTimeList() {
        // リファクタリングする
        timeList.setTime(at: selectedCellIndex + 1, date: timePicker.date)
        timeListView.setTimeList(timeList)
        timeListView.timeCollectionView.reloadData()
        timeListView.timeCollectionView.selectItem(at: IndexPath(row: selectedCellIndex, section: 0), animated: false, scrollPosition: .centeredHorizontally)

        delegate?.saveButtonDidPressed(timeList: timeList)
    }

}

extension TimeListEditViewController: UICollectionViewDelegate {

    // 選択されたセルの番号を保持
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellIndex = indexPath.row
    }

}
