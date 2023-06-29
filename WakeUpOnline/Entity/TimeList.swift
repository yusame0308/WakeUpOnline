//
//  TimeList.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/29.
//

import Foundation

struct TimeList {
    var sunday: Int
    var monday: Int
    var tuesday: Int
    var wednesday: Int
    var thursday: Int
    var friday: Int
    var saturday: Int

    // index(1〜7)から値を取得
    func value(of index: Int) -> Int {
        switch index {
        case 1: return sunday
        case 2: return monday
        case 3: return tuesday
        case 4: return wednesday
        case 5: return thursday
        case 6: return friday
        case 7: return saturday
        default: return monday
        }
    }
}
