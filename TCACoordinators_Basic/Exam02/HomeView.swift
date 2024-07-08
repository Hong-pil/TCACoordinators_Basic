//
//  HomeView.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/8/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct HomeCore {
    struct State: Equatable {
        //var id = UUID()
        public var nums: [Int] = Array(1...10)
    }
    
    enum Action {
        case itemTapped(Int)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .itemTapped(num):
                return .none
//            default:
//                return .none
            }
        }
    }
}

struct HomeView: View {
    let store: StoreOf<HomeCore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            
            List {
                ForEach(viewStore.nums, id: \.self) { num in
                    Button(
                        action: {
                            viewStore.send(.itemTapped(num))
                        },
                        label: { Text("\(num)") }
                    )
                }
            }
            
            
        }

    }
}

#Preview {
    HomeView(
        store: Store(initialState: HomeCore.State()) {
            HomeCore()
        }
    )
}
