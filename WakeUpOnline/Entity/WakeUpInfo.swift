//
//  WakeUpInfo.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/06/08.
//

import Foundation

struct WakeUpInfo {
    let userName: String
    let message: String
    let time: Int
    let iconUrl: String
    let totalDates: Int
    let consecutiveDates: Int
}

let wakeUpInfos = [
    WakeUpInfo(userName: "太郎", message: "がんばります", time: 0800, iconUrl: "", totalDates: 10, consecutiveDates: 3),
    WakeUpInfo(userName: "山田", message: "早起きがんばります", time: 0830, iconUrl: "", totalDates: 4, consecutiveDates: 2),
    WakeUpInfo(userName: "たろう", message: "がんばります", time: 0900, iconUrl: "", totalDates: 8, consecutiveDates: 5),
    WakeUpInfo(userName: "太郎", message: "早起きがんばります", time: 0915, iconUrl: "", totalDates: 2, consecutiveDates: 2),
    WakeUpInfo(userName: "山田", message: "がんばります", time: 0920, iconUrl: "", totalDates: 1, consecutiveDates: 0),
    WakeUpInfo(userName: "タロウ", message: "がんばります", time: 0945, iconUrl: "", totalDates: 9, consecutiveDates: 3),
    WakeUpInfo(userName: "やまだ", message: "がんばります", time: 1000, iconUrl: "", totalDates: 5, consecutiveDates: 5)
]
