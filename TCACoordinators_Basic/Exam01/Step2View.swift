//
//  Step2View.swift
//  TCACoordinators_Basic
//
//  Created by kimhongpil on 7/6/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct Step2Reducer {
    struct State: Equatable, Identifiable {
        var id = UUID()
    }
    
    enum Action {
//    case
        case backgroundTapped
        case dismissPage
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backgroundTapped:
                return .none
            case .dismissPage:
//                usersClient.sendEvent(.didCompleteMemberProcess(result: .guest))
//                usersClient.sendEvent(.didCompleteMemberProcess(result: .member(authorized: true)))
//                usersClient.sendEvent(.didCompleteMemberProcess(result: .member(authorized: false)))

                
                return .none
            default:
                return .none
            }
        }
    }
}

struct Step2View: View {
    let store: StoreOf<Step2Reducer>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Button {
                    viewStore.send(.dismissPage)
                } label: {
                    Text("Dismiss Page")
                }
                .padding()

                Text("Step 2 View!")
                
            }
            .onTapGesture {
                viewStore.send(.backgroundTapped)
            }
        }

    }
}

#Preview {
    Step2View(
        store: Store(initialState: Step2Reducer.State()) {
            Step2Reducer()
        }
    )
}
