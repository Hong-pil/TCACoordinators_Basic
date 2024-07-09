//
//  RepoSearchClient.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/9/24.
//

import Foundation
import ComposableArchitecture
import XCTestDynamicOverlay

struct RepoSearchClient {
    // @Sendable: 동시(concurrently)에 사용해도 안전한 타입
    var search: @Sendable (String) async throws -> RepoSearchModel
}

extension DependencyValues {
    var repoSearchClient: RepoSearchClient {
        get { self[RepoSearchClient.self] }
        set { self[RepoSearchClient.self] = newValue }
    }
}

extension RepoSearchClient: DependencyKey {
    static let liveValue = RepoSearchClient(
      search: { keyword in
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(keyword)") else {
          throw APIError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(RepoSearchModel.self, from: data)
      }
    )
}

extension RepoSearchClient: TestDependencyKey {
    static let previewValue = Self(
        search: { _ in .mock }
    )
    
    static let testValue = Self(
        search: unimplemented("\(Self.self).search")
    )
}



//Workshop 진행 중에 임시로 활용할 코드
//func sampleSearchRequest(keyword: String, send: Send<RepoSearch.Action>) async throws {
// guard let url = URL(string: "https://api.github.com/search/repositories?q=\(keyword)") else {
//   await send(RepoSearch.Action.dataLoaded(.failure(APIError.invalidUrlError)))
//   return
// }
// let (data, _) = try await URLSession.shared.data(from: url)
// let result = await TaskResult { try JSONDecoder().decode(RepositoryModel.self, from: data) }
//
// await send(RepoSearch.Action.dataLoaded(result))
//}
