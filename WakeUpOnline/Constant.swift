//
//  Constant.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/14.
//

import FirebaseFirestore

enum Constant {
    static let userCollectionRef = Firestore.firestore().collection("users")
}
