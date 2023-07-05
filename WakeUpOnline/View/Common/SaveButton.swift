//
//  SaveButton.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/06.
//

import UIKit

final class SaveButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: .zero)

        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString("保存", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 16, weight: .bold)]))
        config.baseForegroundColor = .lightBrown
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        self.configuration = config

        self.layer.cornerRadius = 5
        self.addShadow()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
