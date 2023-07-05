//
//  TimeListView.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/29.
//

import UIKit

protocol TimeListViewDelegate: AnyObject {
    func cellSelected()
}

final class TimeListView: UIView, UICollectionViewDataSource {

    // 起床時間リスト
    let timeCollectionView: UICollectionView

    private let timeList: TimeList

    // layout
    private let horizontalItemCount = 7
    private let itemHeight = 60

    private let cellID = "timeCollectionViewCellID"

    init(width: CGFloat, timeList: TimeList) {
        // FlowLayout
        let flowLayout = UICollectionViewFlowLayout()
        let itemWidth = Int(width) / horizontalItemCount
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumInteritemSpacing = 0

        self.timeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        self.timeList = timeList

        super.init(frame: .zero)

        setupLayout()
        self.addShadow()

        // timeCollectionView
        timeCollectionView.dataSource = self
        timeCollectionView.register(TimeCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        timeCollectionView.layer.cornerRadius = 5
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        self.addSubview(timeCollectionView)

        self.snp.makeConstraints { make in
            make.height.equalTo(itemHeight)
        }

        timeCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return horizontalItemCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = timeCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TimeCollectionViewCell // swiftlint:disable:this force_cast

        cell.render(with: timeList.stringValues(of: indexPath.row+1))

        // 最後のセル以外に区切り線を表示
        if indexPath.row != horizontalItemCount - 1 {
            let separator = CALayer()
            separator.frame = CGRect(x: Int(cell.bounds.width), y: 10, width: 1, height: itemHeight - 20)
            separator.backgroundColor = UIColor.blackBrown.withAlphaComponent(0.2).cgColor
            cell.layer.addSublayer(separator)
        }

        // 選択時の背景色を変更
        let selectedBackgroundView = UIView(frame: cell.frame)
        selectedBackgroundView.backgroundColor = .blackBrown.withAlphaComponent(0.2)
        cell.selectedBackgroundView = selectedBackgroundView

        return cell
    }

}
