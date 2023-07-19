//
//  MyAppCheckProviderFactory.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/07/19.
//

import FirebaseCore
import FirebaseAppCheck

final class MyAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        return AppAttestProvider(app: app)
    }
}
