//
//  MypageViewModel.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/08/16.
//

import Combine

protocol MypageViewModelProtocol {
    func transform(input: MypageViewModelInput, cancellables: inout Set<AnyCancellable>) -> MypageViewModelOutput
}

struct MypageViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
    let profileViewTapped: AnyPublisher<Void, Never>
    let timeListViewTapped: AnyPublisher<Void, Never>
    let profileEditInput: ProfileEditInput
    let timeListEditInput: TimeListEditInput
}

struct ProfileEditInput {
    let profileSaveButtonTapped: PassthroughSubject<UserUpdate, Never> = .init()
}

struct TimeListEditInput {
    let timeListSaveButtonTapped: PassthroughSubject<WakeUpTimeList, Never> = .init()
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

    func transform(input: MypageViewModelInput, cancellables: inout Set<AnyCancellable>) -> MypageViewModelOutput {
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
            .store(in: &cancellables)

        // プロフィール保存ボタンが押されたらFirestoreを更新する
        input.profileEditInput
            .profileSaveButtonTapped
            .sink { userUpdate in
                print(userUpdate)
            }
            .store(in: &cancellables)

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
