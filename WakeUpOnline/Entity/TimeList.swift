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
        let value = getValue(of: index)
        let timeString = timeText(of: value)

        switch index {
        case 1: return ("日", timeString)
        case 2: return ("月", timeString)
        case 3: return ("火", timeString)
        case 4: return ("水", timeString)
        case 5: return ("木", timeString)
        case 6: return ("金", timeString)
        case 7: return ("土", timeString)
        default: return ("月", timeString)
        }
    }

    // index(1〜7)から画面表示用のデータを取得
    func dateValue(of index: Int) -> Date {
        return convertToDate(from: getValue(of: index)) ?? Date()
    }

    // indexを指定して新しい時間を設定
    mutating func setTime(at index: Int, date: Date) {
        let timeInt = convertToInt(from: date) ?? 900

        switch index {
        case 1: sunday = timeInt
        case 2: monday = timeInt
        case 3: tuesday = timeInt
        case 4: wednesday = timeInt
        case 5: thursday = timeInt
        case 6: friday = timeInt
        case 7: saturday = timeInt
        default: monday = timeInt
        }
    }

    private func getValue(of index: Int) -> Int {
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

    // 画面表示用の起床時刻の文字列
    private func timeText(of time: Int) -> String {
        var timeString = String(time)
        timeString.insert(":", at: timeString.index(timeString.endIndex, offsetBy: -2))
        return timeString
    }

    // IntからDateに変換
    private func convertToDate(from time: Int) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        let shortDateString = dateFormatter.string(from: Date())
        let fullDateString = shortDateString + " " + timeText(of: time)

        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        dateTimeFormatter.dateFormat = "yyyy/MM/dd HH:mm"

        return dateTimeFormatter.date(from: fullDateString)
    }

    // DateからIntに変換
    private func convertToInt(from date: Date) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        dateFormatter.dateFormat = "HHmm"

        let formatString = dateFormatter.string(from: date)
        return Int(formatString)
    }
}

let testTimeList = TimeList(sunday: 1030, monday: 800, tuesday: 800, wednesday: 930, thursday: 800, friday: 715, saturday: 1000)
