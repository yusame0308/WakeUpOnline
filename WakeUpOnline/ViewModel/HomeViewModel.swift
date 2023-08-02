//
//  HomeViewModel.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/08/02.
//

import Foundation

protocol HomeViewModelable {
}

final class HomeViewModel {

    private let firestoreClient: FirestoreClientable

    convenience init() {
        self.init(firestoreClient: FirestoreClient())
    }

    init(firestoreClient: FirestoreClientable) {
        self.firestoreClient = firestoreClient
    }
    
}
