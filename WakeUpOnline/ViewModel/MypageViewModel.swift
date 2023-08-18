//
//  MypageViewModel.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/08/16.
//

import Combine

protocol MypageViewModelProtocol {
    var currentUserSubject: CurrentValueSubject<User, Never> { get }
    func transform(input: MypageViewModelInput) -> MypageViewModelOutput
}

struct MypageViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
    let profileViewTapped: AnyPublisher<Void, Never>
    let timeListViewTapped: AnyPublisher<Void, Never>
}

struct MypageViewModelOutput {
    let onFetchCurrentUser: AnyPublisher<User, Never>
    let onPresentProfileEditView: AnyPublisher<User, Never>
    let onPresentTimeListEditView: AnyPublisher<User, Never>
    let onShowErrorAlert: AnyPublisher<String, Never>
}

struct MypageViewModel: MypageViewModelProtocol {

    // Stateとしてまとめて定義する？
    var currentUserSubject = CurrentValueSubject<User, Never>(User(id: ""))

    private let firestoreClient: FirestoreClientable
//    private var subscriptions = Set<AnyCancellable>()

    init() {
        self.init(firestoreClient: FirestoreClient())
    }

    init(firestoreClient: FirestoreClientable) {
        self.firestoreClient = firestoreClient
    }

    func transform(input: MypageViewModelInput) -> MypageViewModelOutput {
//        let didLoad = input
//            .viewDidLoad
//            .share()

//        let currentUser = didLoad
//            .compactMap {
//                Task {
//                    do {
//                        let user = try await firestoreClient.fetchCurrentUser()
//                        currentUserSubject.send(user)
//                    } catch {
//                        errorAlertSubject.send(error.localizedDescription)
//                    }
//                }
//            }

//            .flatMap { _ in
//                var currentUser: User
//                let t = Task {
//                    let c = try await firestoreClient.fetchCurrentUser()
//                }
//                return "aaa".publisher.eraseToAnyPublisher()
//            }

        let errorAlertSubject = PassthroughSubject<String, Never>()

        _ = input.viewDidLoad
            .sink { _ in
                Task {
                    do {
                        let user = try await firestoreClient.fetchCurrentUser()
                        currentUserSubject.send(user)
                    } catch {
                        errorAlertSubject.send(error.localizedDescription)
                    }
                }
            }

        let currentUser = currentUserSubject
            .map { $0 }

        let errorAlert = errorAlertSubject
            .map { $0 }

        let profileViewTapped = input
            .profileViewTapped
            .share()
            .map { currentUserSubject.value }

        let timeListViewTapped = input
            .timeListViewTapped
            .share()
            .map { currentUserSubject.value }

        return .init(
            onFetchCurrentUser: currentUser.eraseToAnyPublisher(),
            onPresentProfileEditView: profileViewTapped.eraseToAnyPublisher(),
            onPresentTimeListEditView: timeListViewTapped.eraseToAnyPublisher(),
            onShowErrorAlert: errorAlert.eraseToAnyPublisher()
        )
    }

//    func fetchCurrentUser() -> Future<User, Error> {
//        return Future() { promise in
//            Task {
//                do {
//                    let user = try await firestoreClient.fetchCurrentUser()
//                    promise(.success(user))
//                } catch {
//                    promise(.failure(error))
//                }
//            }
//        }
//    }

}
