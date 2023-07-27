//
//  FirestoreClient.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseAuth

protocol FirestoreClientable {
    func createUser(_ user: User) throws
    func fetchUserList(startAfter lastSnapshot: DocumentSnapshot?) async throws -> [User]
    func updateUser(id: String, data: [String: Any]) async throws
//    func fetchIconImage() async throws
    func uploadIconImage(data: Data) async throws
}

final class FirestoreClient: FirestoreClientable {

    private let usersCollectionRef = Firestore.firestore().collection("users")
    private let storageRef = Storage.storage().reference()

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

    // ユーザを更新
    func updateUser(id: String, data: [String: Any]) async throws {
        try await usersCollectionRef.document(id).updateData(data)
    }

    // アイコン画像をアップロード
    func uploadIconImage(data: Data) async throws {
        // 画像の名前をuserIDにする
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let imagePath = storageRef.child("icons/\(userID).jpg")

        // ファイルのタイプを指定
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        // Storageにアップロード
        _ = try await imagePath.putDataAsync(data, metadata: metadata)
    }

}