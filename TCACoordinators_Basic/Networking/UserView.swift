//
//  UserView.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/9/24.
//

import SwiftUI
import ComposableArchitecture

struct UserView: View {
    let store: StoreOf<UserFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List {
                ForEach(viewStore.users, id: \.id) { user in
                    Text(user.name)
                }
            }
            .onAppear {
                viewStore.send(.fetchUsers)
            }
        }
    }
}

#Preview {
    UserView(
        store: Store(initialState: UserFeature.State()) {
            UserFeature()
        }
    )
}
