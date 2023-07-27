//
//  User.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/08.
//

import Foundation

struct User: Codable {
    let id: String // ID
    let name: String // 名前
    let message: String // メッセージ
    let wakeUpTimeList: WakeUpTimeList // 起床時刻リスト
    let wakeUpLog: WakeUpLog // 起床記録

    // CodingKeys
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case message
        case wakeUpTimeList = "wake_up_time_list"
        case wakeUpLog = "wake_up_log"
    }

    init(id: String, name: String, message: String, wakeUpTimeList: WakeUpTimeList, wakeUpLog: WakeUpLog) {
        self.id = id
        self.name = name
        self.message = message
        self.wakeUpTimeList = wakeUpTimeList
        self.wakeUpLog = wakeUpLog
    }

    // IDのみ指定するinit
    init(id: String) {
        self.init(id: id, name: "名無し", message: "よろしくお願いします", wakeUpTimeList: WakeUpTimeList(), wakeUpLog: WakeUpLog())
    }
}

let users = [
    User(id: "test-id-1", name: "太郎", message: "がんばります", wakeUpTimeList: testWakeUpTimeList, wakeUpLog: testWakeUpLog),
    User(id: "test-id-2", name: "山田", message: "よろしくお願いします。", wakeUpTimeList: testWakeUpTimeList, wakeUpLog: testWakeUpLog),
    User(id: "test-id-3", name: "テストユーザー", message: "がんばります", wakeUpTimeList: testWakeUpTimeList, wakeUpLog: testWakeUpLog),
    User(id: "test-id-4", name: "田中", message: "よろしくお願いします。よろしくお願いします。", wakeUpTimeList: testWakeUpTimeList, wakeUpLog: testWakeUpLog),
    User(id: "test-id-5", name: "テストテストテストテストテストテストテストテストテスト", message: "がんばります", wakeUpTimeList: testWakeUpTimeList, wakeUpLog: testWakeUpLog),
    User(id: "test-id-6", name: "タロウ", message: "よろしくお願いします。", wakeUpTimeList: testWakeUpTimeList, wakeUpLog: testWakeUpLog),
    User(id: "test-id-7", name: "やまだ", message: "がんばります", wakeUpTimeList: testWakeUpTimeList, wakeUpLog: testWakeUpLog)
]
