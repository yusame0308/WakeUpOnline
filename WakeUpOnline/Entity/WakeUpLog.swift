//
//  WakeUpLog.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/17.
//

import Foundation

struct WakeUpLog {
    let totalCount: Int // 通算記録
    let consecutiveCount: Int // 連続記録
    let dates: [Date] // 起床した日の記録

    // 画面表示のための達成記録の文字列
    var recordText: String {
        return "通算 \(totalCount)\n連続 \(consecutiveCount)"
    }
}

let testWakeUpLog = WakeUpLog(totalCount: 15, consecutiveCount: 3, dates: [Date()])
