//
//  Screen.swift
//  TCACoordinators_Basic
//
//  Created by kimhongpil on 7/6/24.
//

import Foundation
import ComposableArchitecture

//@Reducer(state: .equatable)
//struct Screen {
//    enum State: Equatable, Identifiable {
//        case step1(Step1Reducer.State)
//        case step2(Step2Reducer.State)
//        
//        var id: UUID {
//            switch self {
//            case let .step1(state):
//                return state.id
//            case let .step2(state):
//                return state.id
//            }
//        
//        }
//    }
//    
//    enum Action {
//        case step1(Step1Reducer.Action)
//        case step2(Step2Reducer.Action)
//    }
//    
//    var body: some ReducerOf<Self> {
//        Scope(state: /State.step1, action: /Action.step1) {
//            Step1Reducer()
//        }
//        Scope(state: /State.step2, action: /Action.step2) {
//            Step2Reducer()
//        }
//    }
//}

@Reducer(state: .equatable)
enum Screen {
  case step1(Step1Reducer)
  case step2(Step2Reducer)
}
