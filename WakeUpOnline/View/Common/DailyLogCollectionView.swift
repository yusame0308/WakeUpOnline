//
//  DailyLogCollectionView.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/20.
//

import UIKit

final class DailyLogCollectionView: UICollectionView, UICollectionViewDataSource {

    private let cellID = "dailyLogCellID"

    // layout
    private let horizontalItemCount = 7
    private let verticalItemCount = 5
    private let itemSpacing: CGFloat = 3

    init(width: CGFloat) {
        // FlowLayout
        let flowLayout = UICollectionViewFlowLayout()
        let availableWidth = Int(width) - Int(itemSpacing) * (horizontalItemCount - 1)
        let itemWidth = availableWidth / horizontalItemCount
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.minimumInteritemSpacing = itemSpacing
        flowLayout.minimumLineSpacing = itemSpacing

        super.init(frame: .zero, collectionViewLayout: flowLayout)

        self.dataSource = self
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)

        // 自身のサイズを指定
        self.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: width, height: selfHeight(of: width)))
        }
    }

    // 自身の幅から高さを計算
    private func selfHeight(of width: CGFloat) -> CGFloat {
        let itemWidth = (Int(width) - Int(itemSpacing) * (horizontalItemCount - 1)) / horizontalItemCount
        let selfHeight = itemWidth * verticalItemCount + Int(itemSpacing) * (verticalItemCount - 1)
        return CGFloat(selfHeight)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return horizontalItemCount * verticalItemCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = .accentBrown
        cell.layer.cornerRadius = 4
        return cell
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
