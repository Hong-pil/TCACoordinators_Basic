//
//  UserFeature.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/9/24.
//

import Foundation
import ComposableArchitecture

struct UserFeature: Reducer {
    struct State: Equatable {
        var users: [User] = []
        var isLoading = false
    }
    
    enum Action: Equatable {
        case fetchUsers
        case fetchUsersResponse(TaskResult<[User]>)
        case createUser(name: String, email: String)
        case createUserResponse(TaskResult<User>)
    }
    
    @Dependency(\.networkClient) var networkClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchUsers:
                state.isLoading = true
                return .run { send in
                    let result = await TaskResult {
                        let data = try await networkClient.request(.getUsers)
                        return try JSONDecoder().decode([User].self, from: data)
                    }
                    await send(.fetchUsersResponse(result))
                }
                
            case let .fetchUsersResponse(.success(users)):
                state.users = users
                state.isLoading = false
                return .none
                
            case .fetchUsersResponse(.failure):
                state.isLoading = false
                return .none
                
            case let .createUser(name, email):
                return .run { send in
                    let result = await TaskResult {
                        let data = try await networkClient.request(.createUser(name: name, email: email))
                        return try JSONDecoder().decode(User.self, from: data)
                    }
                    await send(.createUserResponse(result))
                }
                
            case .createUserResponse(.success), .createUserResponse(.failure):
                return .none
            }
        }
    }
}
