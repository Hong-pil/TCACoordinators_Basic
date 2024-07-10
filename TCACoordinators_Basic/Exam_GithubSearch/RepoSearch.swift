//
//  RepoSearch.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/9/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RepoSearch {
    
    @ObservableState
    struct State: Equatable {
        var keyword = ""
        var searchResults = [String]()
        var isLoading = false
    }
    
    enum Action {
        case keywordChanged(String)
        case search
        case dataLoaded(TaskResult<RepoSearchModel>)
        case goDetailPage(String)
    }
    
    // 네트워크 통신
    // old
    @Dependency(\.repoSearchClient) var repoSearchClient
    // new
    @Dependency(\.networkClient) var networkClient
    
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .keywordChanged(keyword):
                state.keyword = keyword
                return .none
            case .search:
                state.isLoading = true
                
                // old
//                return Effect.run { [keyword = state.keyword] send in
//                    let result = await TaskResult { try await repoSearchClient.search(keyword) }
//                    await send(.dataLoaded(result))
//                }
                
                // new
                return .run { [keyword = state.keyword] send in
                    let result = await TaskResult {
                        let data = try await networkClient.request(.gitSearch(txt: keyword))
                        return try JSONDecoder().decode(RepoSearchModel.self, from: data)
                    }
                    
                    await send(.dataLoaded(result))
                }
                
            case let .dataLoaded(.success(repositoryModel)):
                state.isLoading = false
                state.searchResults = repositoryModel.items.map { $0.name }
                return .none
            case .dataLoaded(.failure):
                state.isLoading = false
                state.searchResults = []
                return .none
                
                // 어차피 동작이 필요없기 때문에 default로 대체함
//            case let .goDetailPage(txt):
//                return .none
            default:
                return .none
            }
        }
    }
}
