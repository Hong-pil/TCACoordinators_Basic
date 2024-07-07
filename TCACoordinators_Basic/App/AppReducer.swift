//
//  AppReducer.swift
//  TCACoordinators_Basic
//
//  Created by kimhongpil on 7/6/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct AppReducer {

    struct State: Equatable, Identifiable {
        
        let id = UUID()
        
        public var appDelegate: LiveScoreAppDelegateReducer.State
        public var notiMessage: String?
        
        var coordinatorState = Coordinator.State()
        var isLoadedView = false
        var isLoading: Bool = false
        @BindingState var isShowToast = false
        
    //    @PresentationState public var destination: Destination.State?
        public init(appDelegate: LiveScoreAppDelegateReducer.State = LiveScoreAppDelegateReducer.State()) {
            self.appDelegate = appDelegate
        }
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case appDelegate(LiveScoreAppDelegateReducer.Action)
        case didChangeScenePhase(ScenePhase)
        case onAppear
        case onLoad
        case showLoadingReceived(Bool)
        case task
        case memberTask
        case coordinatorAction(Coordinator.Action)
    }
    
    public var body: some ReducerOf<Self> {
        self.core
    }
    
    @ReducerBuilder<State, Action>
    var core: some ReducerOf<Self> {
        BindingReducer()
        Scope(state: \.appDelegate, action: \.appDelegate) {
            LiveScoreAppDelegateReducer()
        }
        Scope(state: \.coordinatorState, action: \.coordinatorAction) {
            Coordinator()
        }
        Reduce { state, action in
            switch action {
            case .task:
                return .run { send in
                }
            case .memberTask:
                return .run { send in
                }
            case .showLoadingReceived(let isLoading):
                state.isLoading = isLoading
                return .none
            case .appDelegate(.didFinishLaunching):
                // 이미지 캐시 기본 캐시 만료시간 설정
//                let cache = ImageCache.default
//                cache.diskStorage.config.expiration = .days(30)
                return .none
            case let .appDelegate(.openURL(url)):
                return .none
            case .appDelegate:
                return .none
            case .didChangeScenePhase(.active):
                return .run { _ in
                }
            case .onLoad:
                state.isLoadedView = true
                return .none
            case .onAppear:
                NSSetUncaughtExceptionHandler { exception in
                    print("UncaughtException : \(exception)")
                    print("UncaughtException callStackSymbol : \(exception.callStackSymbols)")
                }
                return .none
            case .binding:
                return .none
            default:
                return .none
            }
            
        }
//        ._printChanges()
    }
    
}


