//
//  String-Extension.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/18.
//

import UIKit

extension String {
    func attributedStringWithLineHeightMultiple(by heightMultiple: CGFloat) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = heightMultiple

        return NSAttributedString(string: self, attributes: [.paragraphStyle: paragraph])
    }

    func attributedStringWithKern(_ kern: CGFloat) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.kern: kern])
    }
}
