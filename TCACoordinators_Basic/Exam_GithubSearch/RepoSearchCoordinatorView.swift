//
//  RepoSearchCoordinatorView.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/9/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

@Reducer(state: .equatable)
enum RepoSearchScreen {
    case search(RepoSearch)
    case detail(RepoSearchDetail)
}

@Reducer
struct RepoSearchCoordinator {
    
    @ObservableState
    struct State: Equatable {
        //static let initialState = State()
        var routes: [Route<RepoSearchScreen.State>]
        
        init(routes: [Route<RepoSearchScreen.State>] = [.root(.search(RepoSearch.State()), embedInNavigationView: true)]) {
            self.routes = routes
        }
    }
    
    enum Action {
        case router(IndexedRouterActionOf<RepoSearchScreen>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case let .router(.routeAction(_, action: .search(.goDetailPage(txt)))):
                state.routes.push(.detail(.init(title: txt)))
            case .router(.routeAction(_, action: .detail(.dismissPage))):
                state.routes.goBackToRoot()
                
            default:
                break
            }
            return .none
        }
        .forEachRoute(\.routes, action: \.router)
        ._printChanges()
    }
}

struct RepoSearchCoordinatorView: View {
    let store: StoreOf<RepoSearchCoordinator>
    
    var body: some View {
        TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
            switch screen.case {
            case let .search(store):
                RepoSearchView(store: store)
                
            case let .detail(store):
                RepoSearchDetailView(store: store)
            }
        }
    }
}
