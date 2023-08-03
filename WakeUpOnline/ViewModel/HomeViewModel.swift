//
//  HomeViewModel.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/08/02.
//

import Combine
import FirebaseFirestore

protocol HomeViewModelable {
    var userListSubject: CurrentValueSubject<[User], Never> { get }
    var isLoadingSubject: PassthroughSubject<Bool, Never> { get }
    var errorAlertSubject: PassthroughSubject<String, Never> { get }
    func fetchUserList() async
}

final class HomeViewModel {

    var userListSubject = CurrentValueSubject<[User], Never>([])
    var isLoadingSubject = PassthroughSubject<Bool, Never>()
    var errorAlertSubject = PassthroughSubject<String, Never>()

    private let firestoreClient: FirestoreClientable
    private var lastSnapshot: DocumentSnapshot?

    convenience init() {
        self.init(firestoreClient: FirestoreClient())
    }

    init(firestoreClient: FirestoreClientable) {
        self.firestoreClient = firestoreClient
    }

    @MainActor private func setupLoading(_ isLoading: Bool) {
        isLoadingSubject.send(isLoading)
    }

    @MainActor private func appendUserList(_ userList: [User]) {
        userListSubject.send(userListSubject.value + userList)
    }

    @MainActor private func showErrorAlert(_ message: String) {
        errorAlertSubject.send(message)
    }

}

extension HomeViewModel: HomeViewModelable {

    // ユーザリストを取得
    func fetchUserList() async {
        do {
            await setupLoading(true)

            // Firestoreから取得
            let fetchedData = try await firestoreClient.fetchUserList(startAfter: lastSnapshot)
            await appendUserList(fetchedData.userList)
            lastSnapshot = fetchedData.lastSnapshot

            await setupLoading(false)
        } catch {
            await setupLoading(false)
            await showErrorAlert(error.localizedDescription)
        }
    }

}
