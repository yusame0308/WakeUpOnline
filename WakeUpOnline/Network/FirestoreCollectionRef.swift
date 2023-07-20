//
//  FirestoreCollectionRef.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/20.
//

import FirebaseFirestore

struct FirestoreCollectionRef {
    static let users = Firestore.firestore().collection("users")
}
