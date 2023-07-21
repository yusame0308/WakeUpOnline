//
//  FirestoreClient.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/20.
//

import Foundation
import FirebaseFirestore

protocol FirestoreClientable {
    func createUser()
    func fetchUserList() async throws -> UserList
    func updateUser()
    func fetchIconImage() async throws
    func uploadIconImage()
}

final class FirestoreClient {
    private let usersCollectionRef = Firestore.firestore().collection("users")
}
