//
//  CoordinatorView_Exam02.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/8/24.
//

import SwiftUI
import TCACoordinators
import ComposableArchitecture

// 앱의 화면들을 정의하는 열거형
@Reducer(state: .equatable)
enum Screen_Exam02 {
  case home(HomeCore)
  case detail(DetailCore)
}

// 전체 네비게이션 흐름을 관리하는 리듀서
@Reducer
struct Coordinator_Exam02 {
    
    /// @ObservableState : State 변화를 감지하고 뷰를 업데이트하는 역할
    /// Equatable 프로토콜 : Equatable 프로토콜 채택시, State 변화가 발생했을 때 이전 State와 새로운 State를 비교할 수 있게 해줌. 이를 통한 불필요한 뷰 업데이트를 방지함.
    @ObservableState
    struct State: Equatable {
        
        /// 초기 상태 정의 (이거 왜 필요함? 일단 주석처리함)
        //static let initialState = State()
        
        /// [Route<>] 에서 Route를 타고 들어가 보면,  public enum Route<Screen> 으로 되어 있다.
        /// 현재 네비게이션의 경로를 나타내는 배열이다. 즉, 현재 보여지는 화면이다.
        var routes: [Route<Screen_Exam02.State>]

        /// 초기화 메서드는 기본적으로 home 화면을 루트로 설정한다.
        init(routes: [Route<Screen_Exam02.State>] = [.root(.home(HomeCore.State()), embedInNavigationView: true)]) {
            self.routes = routes
        }
    }
    
    /// IndexedRouterActionOf :
    /// : TCACoordinators 라이브러리에서 제공하는 제네릭 타입.
    /// 새 화면으로 이동, 뒤로 가기, 특정 화면으로 직접 이동 등의 '라우터의 모든 가능한 액션'을 포함한다. (이 액션들은 라우터에서 실행함)
    enum Action {
        // 리듀서가 처리할 수 있는 액션들 정의
        case router(IndexedRouterActionOf<Screen_Exam02>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case let .router(.routeAction(_, action: .home(.itemTapped(num)))):
                state.routes.push(.detail(.init(title: num)))
            case .router(.routeAction(_, action: .detail(.backButtonTapped))):
                state.routes.pop()
            default:
                break
            }
            return .none
        }
        /// .forEachRoute 설명
        /// .forEachRoute는 TCACoordinators에서 제공하는 메서드인데, 네비게이션 각 스택의 각 라우트(화면)에 대해 특정 리듀서를 적용한다.
        /// 네비게이션 스택의 각 화면(라우트)에 대해 개별적으로 리듀서를 적용한다.
        .forEachRoute(\.routes, action: \.router)
        ._printChanges()
    }
}

// 실제 UI를 구성하는 SwiftUI 뷰. TCARouter를 사용하여 현재 화면에 맞는 뷰를 표시한다.
struct CoordinatorView_Exam02: View {
    let store: StoreOf<Coordinator_Exam02>
    
    var body: some View {
        TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
            switch screen.case {
            case let .home(store):
                HomeView(store: store)
                
            case let .detail(store):
                DetailView(store: store)
            }
        }
    }
}

#Preview {
    CoordinatorView_Exam02(
        store: Store(initialState: Coordinator_Exam02.State()) {
            Coordinator_Exam02()
        }
    )
        .environment(\.locale, Locale(identifier: "ko"))

}
