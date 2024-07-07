//
//  TCACoordinators_BasicAppView.swift
//  TCACoordinators_Basic
//
//  Created by kimhongpil on 7/6/24.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct TCACoordinators_BasicAppView: View {
    @State var store: StoreOf<AppReducer>
    
    public var body: some View {
        CoordinatorView(store: self.store.scope(state: \.coordinatorState, action: \.coordinatorAction))
    }
}

#Preview {
    TCACoordinators_BasicAppView(
        store: Store(initialState: AppReducer.State()) {
            AppReducer()
        }
    )
}
