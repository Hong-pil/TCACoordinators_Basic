//
//  DetailView.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/8/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct DetailCore {
    struct State: Equatable {
        public var title: Int
    }
    
    enum Action {
        case backButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backButtonTapped:
                return .none
//            default:
//                return .none
            }
        }
    }
}

struct DetailView: View {
    let store: StoreOf<DetailCore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            
            Text("\(viewStore.title)")
            Button(
                action: { viewStore.send(.backButtonTapped) },
                label: { Text("Go back to list view") }
            )
            
        }
        .navigationBarHidden(true)

    }
}

#Preview {
    DetailView(
        store: Store(initialState: DetailCore.State(title: 0)) {
            DetailCore()
        }
    )
}
