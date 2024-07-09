//
//  NetworkClient.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/9/24.
//

import Foundation
import ComposableArchitecture

/// 아래와 같이 DependencyClient를 등록했다면 Reducer 안에서 @Dependency로 선언하여 별도의 init 없이 사용할 수 있다. Dependency가 Injection 된다고 이해하면 됨.
@DependencyClient
struct NetworkClient {
    var request: (_ router: APIRouter) async throws -> Data
}

extension NetworkClient: DependencyKey {
    static let liveValue = NetworkClient(
        request: { router in
            let request = try router.asURLRequest()
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
        }
    )
}

extension DependencyValues {
    var networkClient: NetworkClient {
        get { self[NetworkClient.self] }
        set { self[NetworkClient.self] = newValue }
    }
}
