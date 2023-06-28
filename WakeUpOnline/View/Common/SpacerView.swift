//
//  SpacerView.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/29.
//

import UIKit

final class SpacerView: UIView {

    init(width: CGFloat = 0, height: CGFloat = 0) {
        super.init(frame: .zero)

        self.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: width, height: height))
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
