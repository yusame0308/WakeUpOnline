//
//  WakeUpInfo.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/08.
//

import Foundation

struct WakeUpInfo {
    let userName: String // 名前
    let message: String // メッセージ
    let time: Int // 起床時刻
    let iconUrl: String // アイコンURL
    let totalDates: Int // 通算記録
    let consecutiveDates: Int // 連続記録

    // 画面表示のための起床時刻の文字列
    var timeText: String {
        var timeString = String(time)
        timeString.insert(":", at: timeString.index(timeString.endIndex, offsetBy: -2))
        return timeString
    }

    // 画面表示のための達成記録の文字列
    var recordText: String {
        return "通算 \(totalDates)\n連続 \(consecutiveDates)"
    }
}

let wakeUpInfos = [
    WakeUpInfo(userName: "太郎", message: "がんばります", time: 800, iconUrl: "", totalDates: 10, consecutiveDates: 3),
    WakeUpInfo(userName: "山田", message: "よろしくお願いします。", time: 830, iconUrl: "", totalDates: 4, consecutiveDates: 2),
    WakeUpInfo(userName: "テストユーザー", message: "がんばります", time: 900, iconUrl: "", totalDates: 8, consecutiveDates: 5),
    WakeUpInfo(userName: "田中", message: "よろしくお願いします。よろしくお願いします。", time: 915, iconUrl: "", totalDates: 85, consecutiveDates: 2),
    WakeUpInfo(userName: "テストテストテストテストテストテストテストテストテスト", message: "がんばります", time: 920, iconUrl: "", totalDates: 1, consecutiveDates: 0),
    WakeUpInfo(userName: "タロウ", message: "よろしくお願いします。", time: 945, iconUrl: "", totalDates: 9, consecutiveDates: 3),
    WakeUpInfo(userName: "やまだ", message: "がんばります", time: 1000, iconUrl: "", totalDates: 5, consecutiveDates: 5)
]
