//
//  TCACoordinators_BasicApp.swift
//  TCACoordinators_Basic
//
//  Created by kimhongpil on 7/6/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCACoordinators_BasicApp: App {
    var body: some Scene {
        WindowGroup {
            //ContentView()
            
            TCACoordinators_BasicAppView(
                store: Store(initialState: AppReducer.State()) {
                    AppReducer()
                }
            )
            
        }
    }
}
