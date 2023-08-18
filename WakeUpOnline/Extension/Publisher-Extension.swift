//
//  Publisher-Extension.swift
//  WakeUpOnline
//
//  Created by 小原宙 on 2023/08/18.
//

import Combine

// 使われていない
extension Publisher {
    public func tryAwaitMap<T>(_ transform: @escaping (Self.Output) async throws -> T) -> Publishers.FlatMap<Future<T, Error>, Self> {
        flatMap { value in
            Future { promise in
                Task {
                    do {
                        let result = try await transform(value)
                        promise(.success(result))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }
}
