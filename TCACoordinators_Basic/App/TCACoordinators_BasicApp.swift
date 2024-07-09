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
            
            /// Build 1
//            TCACoordinators_BasicAppView(
//                store: Store(initialState: AppReducer.State()) {
//                    AppReducer()
//                }
//            )
            
            /// Build 2
//            CoordinatorView(
//                store: Store(initialState: Coordinator.State()) {
//                    Coordinator()
//                }
//            )
            
            /// Build 3
//            CoordinatorView_Exam02(
//                store: Store(initialState: Coordinator_Exam02.State()) {
//                    Coordinator_Exam02()
//                }
//            )
            
            
            RepoSearchCoordinatorView(
                store: Store(initialState: RepoSearchCoordinator.State()) {
                    RepoSearchCoordinator()
                }
            )
            
            
        }
    }
}
