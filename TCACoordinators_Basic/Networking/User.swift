//
//  User.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/9/24.
//

import Foundation

struct User: Equatable, Identifiable, Codable {
    let id: Int
    let name: String
    let email: String
}
