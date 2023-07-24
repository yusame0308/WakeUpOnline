//
//  FirestoreClient.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol FirestoreClientable {
    func createUser(_ user: User) throws
    func fetchUserList(startAfter lastSnapshot: DocumentSnapshot?) async throws -> [User]
//    func updateUser()
//    func fetchIconImage() async throws
//    func uploadIconImage()
}

final class FirestoreClient: FirestoreClientable {

    private let usersCollectionRef = Firestore.firestore().collection("users")

    // ユーザを新規作成
    func createUser(_ user: User) throws {
        try usersCollectionRef.document(user.id).setData(from: user)
    }

    // ユーザリストを取得
    func fetchUserList(startAfter lastSnapshot: DocumentSnapshot? = nil) async throws -> [User] {
        // 今日の曜日
        let weekdayString = Date().weekdayString
        // 検索クエリ
        var query = usersCollectionRef.order(by: "wake_up_time_list.\(weekdayString)")
        // ページネーションを設定
        if let lastSnapshot = lastSnapshot {
            query = query.start(afterDocument: lastSnapshot)
        }

        // データを取得
        let snapshot = try await query.limit(to: 20).getDocuments()

        // User型にキャスト
        let userList: [User] = try snapshot.documents.map { queryDocumentSnapshot in
            return try queryDocumentSnapshot.data(as: User.self)
        }
        return userList
    }

}
