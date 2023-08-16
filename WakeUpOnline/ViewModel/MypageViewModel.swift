//
//  MypageViewModel.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/08/16.
//

import Combine

protocol MypageViewModelProtocol {
    func transform(input: MypageViewModelInput) -> MypageViewModelOutput
}

struct MypageViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
    let profileViewTapped: AnyPublisher<String, Never>
    let timeListViewTapped: AnyPublisher<String, Never>
}

struct MypageViewModelOutput {
    let onFetchCurrentUser: AnyPublisher<User, Never>
    let onPresentProfileEditView: AnyPublisher<User, Never>
    let onPresentTimeListEditView: AnyPublisher<User, Never>
}

struct MypageViewModel: MypageViewModelProtocol {

    private let firestoreClient: FirestoreClientable

    init() {
        self.init(firestoreClient: FirestoreClient())
    }

    init(firestoreClient: FirestoreClientable) {
        self.firestoreClient = firestoreClient
    }

    func transform(input: MypageViewModelInput) -> MypageViewModelOutput {
    }

}
