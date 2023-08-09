//
//  FirestoreError.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/08/09.
//

import Foundation

enum FirestoreError: LocalizedError {
    case customError(message: String)
    case unauthorizedError
    case unknownError

    var errorDescription: String? {
        switch self {
        case .customError(let message):
            return message
        case .unauthorizedError:
            return "ユーザ認証がされていません。"
        case .unknownError:
            return "不具合が発生しました。"
        }
    }
}
