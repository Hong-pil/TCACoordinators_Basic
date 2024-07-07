//
//  LiveScoreAppDelegate.swift
//  TCACoordinators_Basic
//
//  Created by kimhongpil on 7/6/24.
//

import UIKit
import ComposableArchitecture

@Reducer
public struct LiveScoreAppDelegateReducer {
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case didFinishLaunching
        case openURL(_ url: URL)
        case didRegisterForRemoteNotification(Result<Data, Error>)
    }
    
    public var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
            case let .openURL(url):
//                if let pushModel = convertPushType(from: url) {
//                    handlePush(pushModel: pushModel)
//                }

                return .none
            case .didFinishLaunching:
                return .run { send in
                }
            case .didRegisterForRemoteNotification(.failure):
                return .none
            case let .didRegisterForRemoteNotification(.success(tokenData)):
                return .none
            }
        }
    }
}


class LiveScoreAppDelegate: NSObject, UIApplicationDelegate {
    let store = Store(initialState: AppReducer.State()) {
        AppReducer().transformDependency(\.self) { dependency in
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.store.send(.appDelegate(.didFinishLaunching))
        print("앱 시작")
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.store.send(.appDelegate(.didRegisterForRemoteNotification(.success(deviceToken))))
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        self.store.send(.appDelegate(.didRegisterForRemoteNotification(.failure(error))))
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        self.store.send(.appDelegate(.openURL(url)))
        return true
    }
}
