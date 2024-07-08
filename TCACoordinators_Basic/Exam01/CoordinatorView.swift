//
//  CoordinatorView.swift
//  TCACoordinators_Basic
//
//  Created by kimhongpil on 7/6/24.
//

import SwiftUI
import TCACoordinators
import ComposableArchitecture

@Reducer
struct Coordinator {
    
    @ObservableState
    struct State: Equatable {
        static let initialState = State()
        var routes: [Route<Screen.State>]

//        init(routes: [Route<Screen.State>] = [.root(.main(.initialState), embedInNavigationView: true)]) {
//            self.routes = routes
//        }
        
//        init(routes: [Route<Screen.State>] = [.root(.guide1(Guide1Reducer.State()), embedInNavigationView: true)]) {
//            self.routes = routes
//        }
        init(routes: [Route<Screen.State>] = [.root(.step1(Step1Reducer.State()), embedInNavigationView: true)]) {
            self.routes = routes
        }
        
        
//        init(routes: [Route<Screen.State>] = [.root(.koo(KooContentReducer.State()), embedInNavigationView: true)]) {
//            self.routes = routes
//        }
        
    }
    
    enum Action {
//        case routeAction(Int, action: Screen.Action)
//        case updateRoutes([Route<Screen.State>])
        
        case router(IndexedRouterActionOf<Screen>)
    }
    
//    var body: some ReducerOf<Self> {
//        Reduce { state, action in
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .router(.routeAction(_, action: .step1(.nextPage))):
                state.routes.push(.step2(.init()))
            case .router(.routeAction(_, action: .step2(.dismissPage))):
                state.routes.goBackToRoot()
                //state.routes.dismiss()
                
            default:
                break
            }
            return .none
        }
//        .forEachRoute {
//            Screen()
//        }
        .forEachRoute(\.routes, action: \.router)
//        ._printChanges()
    }
}

struct CoordinatorView: View {
    let store: StoreOf<Coordinator>
    
    var body: some View {
        TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
            switch screen.case {
            case let .step1(store):
                Step1View(store: store)
                
            case let .step2(store):
                Step2View(store: store)
            }
        }
    }
}


//struct CoordinatorView: View {
//    var store: StoreOf<Coordinator>
//    
//    var body: some View {
//        TCARouter(self.store) { screen in
//            SwitchStore(screen) { screen in
//                switch(screen) {
//                case .step1:
//                    CaseLet(/Screen.State.step1, action: Screen.Action.step1) { store in
//                        Step1View(store: store)
//                    }
//                case .step2:
//                    CaseLet(/Screen.State.step2, action: Screen.Action.step2) { store in
//                        Step2View(store: store)
//                    }
//                }
//            }
//        }
//    }
//}

#Preview {
    CoordinatorView(
        store: Store(initialState: Coordinator.State()) {
            Coordinator()
        }
    )
        .environment(\.locale, Locale(identifier: "ko"))

}
