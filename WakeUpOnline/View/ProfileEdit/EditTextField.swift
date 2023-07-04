//
//  EditTextField.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/26.
//

import UIKit

final class EditTextField: UITextField {

    init(placeholder: String, textColor: UIColor, fontSize: CGFloat) {
        super.init(frame: .zero)

        self.placeholder = placeholder
        self.textColor = textColor
        textAlignment = .center
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        self.addShadow()
        let frame = CGRect(x: 0, y: 0, width: 16, height: 0)
        leftView = UIView(frame: frame)
        leftViewMode = .always
        rightView = UIView(frame: frame)
        rightViewMode = .always
        returnKeyType = .done
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
