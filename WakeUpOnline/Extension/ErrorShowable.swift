//
//  ErrorShowable.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/08/27.
//

import UIKit

protocol ErrorShowable {
    func showErrorAlert(message: String)
}

extension ErrorShowable where Self: UIViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
