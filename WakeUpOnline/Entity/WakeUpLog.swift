//
//  WakeUpLog.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/17.
//

import Foundation

struct WakeUpLog: Codable {
    let dates: [Date] // 起床した日付リスト
    let totalCount: Int // 通算記録
    let consecutiveCount: Int // 連続記録

    // CodingKeys
    private enum CodingKeys: String, CodingKey {
        case dates
    }

    init(dates: [Date]) {
        self.dates = dates
        self.totalCount = dates.count
        // 計算するように変更する
        self.consecutiveCount = dates.count
    }

    // 値を指定しないinit
    init() {
        self.init(dates: [])
    }

    // decoder init
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dates = try values.decode([Date].self, forKey: .dates)
        self.init(dates: dates)
//        totalCount = dates.count
//        consecutiveCount = dates.count
    }

    // 画面表示のための達成記録の文字列
    var recordText: String {
        return "通算 \(totalCount)\n連続 \(consecutiveCount)"
    }
}

let testWakeUpLog = WakeUpLog(dates: [Date()])
