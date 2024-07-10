//
//  RepoSearchDetail.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/9/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RepoSearchDetail {
    struct State: Equatable {
        public var title: String
    }
    
    enum Action {
        case backgroundTapped
        case goBackToRootPage
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backgroundTapped:
                return .none
            case .goBackToRootPage:
                return .none
            }
        }
    }
}
