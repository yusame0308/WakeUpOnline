//
//  TimeListView.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/29.
//

import UIKit

final class TimeListView: UIView {

    init(timeList: TimeList) {
        super.init(frame: .zero)
        let a = timeList.value(of: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
