//
//  EditTextField.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/26.
//

import UIKit

final class EditTextField: UITextField {

    init(placeholder: String) {
        super.init(frame: .zero)

        self.placeholder = placeholder
        textColor = .gray
        font = UIFont.systemFont(ofSize: 16, weight: .medium)
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 6
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
