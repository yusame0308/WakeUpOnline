//
//  Date-Extension.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/06.
//

import Foundation

extension Date {
    // 4:00と12:00のDateを作成
    static let availableDateRange: (start: Date?, end: Date?) = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none

        let shortDateString = dateFormatter.string(from: Date())
        let startDateString = shortDateString + " 4:00"
        let endDateString = shortDateString + " 12:00"

        dateFormatter.timeStyle = .short
        return (dateFormatter.date(from: startDateString), dateFormatter.date(from: endDateString))
    }()

    // 曜日の文字列を取得
    static let weekdayString: String = {
        // 曜日の数値
        let weekdayInt = Date.weekdayInt
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US")

        return calendar.weekdaySymbols[weekdayInt-1].lowercased()
    }()

    // 曜日の数値を取得
    static let weekdayInt: Int = {
        let today = Date()
        let weekdayInt = Calendar.current.component(.weekday, from: today)
        let hour = Calendar.current.component(.hour, from: today)
        // 15時以前なら当日、15時以後なら翌日の曜日を返却
        return hour < 15 ? weekdayInt : weekdayInt+1
    }()
}
