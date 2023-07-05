//
//  TimeListEditViewController.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/03.
//

import UIKit

final class TimeListEditViewController: UIViewController {

    private var timeList: TimeList

    // タイトルラベル
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "起床時間を編集"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .blackBrown
        return label
    }()

    // 起床時間リスト
    private lazy var timeListView = TimeListView(width: view.bounds.width - 40, timeList: timeList)

    init(timeList: TimeList) {
        self.timeList = timeList

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // セルを選択状態にする
        timeListView.timeCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        timeListView.timeCollectionView.delegate = self

        setupLayout()
        setupAction()
    }

    private func setupLayout() {
        // プロフィールのStackView
        let baseStackView = UIStackView(arrangedSubviews: [titleLabel, timeListView])
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
    }

    private func setupAction() {
    }

}

extension TimeListEditViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

}
