//
//  MypageViewModel.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/08/16.
//

import Combine

protocol MypageViewModelProtocol {
    func transform(input: MypageViewModelInput, subscriptions: inout Set<AnyCancellable>) -> MypageViewModelOutput
}

struct MypageViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
    let profileViewTapped: AnyPublisher<Void, Never>
    let timeListViewTapped: AnyPublisher<Void, Never>
}

struct MypageViewModelOutput {
    let currentUser: AnyPublisher<User, Never>
    let presentProfileEditView: AnyPublisher<User, Never>
    let presentTimeListEditView: AnyPublisher<User, Never>
    let showErrorAlert: AnyPublisher<String, Never>
}

struct MypageViewModel: MypageViewModelProtocol {

    // Stateとしてまとめて定義する？
    private var currentUserSubject = CurrentValueSubject<User?, Never>(nil)

    private let firestoreClient: FirestoreClientable

    init() {
        self.init(firestoreClient: FirestoreClient())
    }

    init(firestoreClient: FirestoreClientable) {
        self.firestoreClient = firestoreClient
    }

    func transform(input: MypageViewModelInput, subscriptions: inout Set<AnyCancellable>) -> MypageViewModelOutput {
        let errorAlertSubject = PassthroughSubject<String, Never>()

        // inputのviewDidLoadが呼ばれたらFirestoreからユーザを取得する
        input
            .viewDidLoad
            .sink {
                Task {
                    do {
                        let user = try await firestoreClient.fetchCurrentUser()
                        currentUserSubject.send(user)
                    } catch {
                        errorAlertSubject.send(error.localizedDescription)
                    }
                }
            }
            .store(in: &subscriptions)

        // compactMapでnilを除去
        let currentUser = currentUserSubject
            .compactMap { $0 }

        let profileViewTapped = input
            .profileViewTapped
            .compactMap { currentUserSubject.value }

        let timeListViewTapped = input
            .timeListViewTapped
            .compactMap { currentUserSubject.value }

        return .init(
            currentUser: currentUser.eraseToAnyPublisher(),
            presentProfileEditView: profileViewTapped.eraseToAnyPublisher(),
            presentTimeListEditView: timeListViewTapped.eraseToAnyPublisher(),
            showErrorAlert: errorAlertSubject.eraseToAnyPublisher()
        )
    }

}
