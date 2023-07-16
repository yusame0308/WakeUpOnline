//
//  User.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/08.
//

import Foundation

struct User {
    let name: String // 名前
    let message: String // メッセージ
    let iconUrl: String // アイコンURL
    let wakeUpTimeList: WakeUpTimeList // 起床時刻リスト
    let wakeUpLog: WakeUpLog // 起床記録
}

let users = [
    User(name: "太郎", message: "がんばります", iconUrl: "", wakeUpTimeList: testWakeUpTimeList, wakeUpLog: testWakeUpLog),
    User(name: "山田", message: "よろしくお願いします。", iconUrl: "", wakeUpTimeList: testWakeUpTimeList, wakeUpLog: testWakeUpLog),
    User(name: "テストユーザー", message: "がんばります", iconUrl: "", wakeUpTimeList: testWakeUpTimeList, wakeUpLog: testWakeUpLog),
    User(name: "田中", message: "よろしくお願いします。よろしくお願いします。", iconUrl: "", wakeUpTimeList: testWakeUpTimeList, wakeUpLog: testWakeUpLog),
    User(name: "テストテストテストテストテストテストテストテストテスト", message: "がんばります", iconUrl: "", wakeUpTimeList: testWakeUpTimeList, wakeUpLog: testWakeUpLog),
    User(name: "タロウ", message: "よろしくお願いします。", iconUrl: "", wakeUpTimeList: testWakeUpTimeList, wakeUpLog: testWakeUpLog),
    User(name: "やまだ", message: "がんばります", iconUrl: "", wakeUpTimeList: testWakeUpTimeList, wakeUpLog: testWakeUpLog)
]
