//
//  RepoSearchView.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/9/24.
//

import SwiftUI
import ComposableArchitecture

struct RepoSearchView: View {
    
    @State var store: StoreOf<RepoSearch>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    TextField(
                        "Search repo",
                        text: Binding(
                            get: { viewStore.keyword },
                            set: { viewStore.send(.keywordChanged($0))}
                        )
                    )
                    .textFieldStyle(.roundedBorder)
                    
                    Button("Search") {
                        viewStore.send(.search)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                
                if store.isLoading {
                    Spacer()
                    ProgressView()
                } else {
                    List {
                        ForEach(viewStore.searchResults, id: \.self) { item in
                            Text(item)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                                .padding(5)
                                .onTapGesture {
                                    print("idpil::: called click item")
                                    viewStore.send(.goDetailPage(item))
                                }
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    RepoSearchView(
        store: Store(initialState: RepoSearch.State()) {
            RepoSearch()
        }
    )
}
