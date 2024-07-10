//
//  RepoSearchDetailView.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/9/24.
//

import SwiftUI
import ComposableArchitecture

struct RepoSearchDetailView: View {
    let store: StoreOf<RepoSearchDetail>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                
                Button(action: {
                    viewStore.send(.goBackToRootPage)
                }, label: {
                    Text("Go to RootPage")
                })
                .padding()
                
                Text(viewStore.title)
            }
            .onTapGesture {
                viewStore.send(.backgroundTapped)
            }
        }
    }
}

#Preview {
    RepoSearchDetailView(
        store: Store(initialState: RepoSearchDetail.State(title: "init")) {
            RepoSearchDetail()
        }
    )
}
