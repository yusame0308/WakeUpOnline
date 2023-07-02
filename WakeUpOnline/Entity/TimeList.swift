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

    // index(1〜7)から画面表示用のデータを取得
    func stringValues(of index: Int) -> (weekDay: String, time: String) {
        switch index {
        case 1: return ("日", timeText(of: sunday))
        case 2: return ("月", timeText(of: monday))
        case 3: return ("火", timeText(of: tuesday))
        case 4: return ("水", timeText(of: wednesday))
        case 5: return ("木", timeText(of: thursday))
        case 6: return ("金", timeText(of: friday))
        case 7: return ("土", timeText(of: saturday))
        default: return ("月", timeText(of: monday))
        }
    }

    // 画面表示のための起床時刻の文字列
    private func timeText(of time: Int) -> String {
        var timeString = String(time)
        timeString.insert(":", at: timeString.index(timeString.endIndex, offsetBy: -2))
        return timeString
    }
}

let testTimeList = TimeList(sunday: 1030, monday: 800, tuesday: 800, wednesday: 930, thursday: 800, friday: 715, saturday: 1000)
