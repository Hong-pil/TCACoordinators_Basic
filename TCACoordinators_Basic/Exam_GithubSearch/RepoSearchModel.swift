//
//  RepoSearchModel.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/9/24.
//

import Foundation

struct RepoSearchModel: Decodable, Equatable, Sendable {
    var items: [Result]
    
    struct Result: Decodable, Equatable, Sendable {
        var name: String
        
        enum CodingKeys: String, CodingKey {
            case name = "full_name"
        }
    }
}

// MARK: - Mock data
extension RepoSearchModel {
    static let mock = Self(
        items: [
            RepoSearchModel.Result(name: "Swift"),
            RepoSearchModel.Result(name: "SwiftyJSON"),
            RepoSearchModel.Result(name: "SwiftGuide"),
            RepoSearchModel.Result(name: "SwiftterSwift"),
        ]
    )
}
