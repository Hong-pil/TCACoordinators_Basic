//
//  Step1View.swift
//  TCACoordinators_Basic
//
//  Created by kimhongpil on 7/6/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct Step1Reducer {
    struct State: Equatable, Identifiable {
        var id = UUID()
    }
    
    enum Action {
        case backgroundTapped
        case nextPage
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backgroundTapped:
                return .none
            case .nextPage:
                return .none
            default:
                return .none
            }
        }
    }
}

struct Step1View: View {
    let store: StoreOf<Step1Reducer>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Button {
                    viewStore.send(.nextPage)
                } label: {
                    Text("다음 페이지로")
                }
                .padding()

                Text("Step 1 View!")
            }
            .onTapGesture {
                viewStore.send(.backgroundTapped)
            }
        }

    }
}

#Preview {
    Step1View(
        store: Store(initialState: Step1Reducer.State()) {
            Step1Reducer()
        }
    )
}
