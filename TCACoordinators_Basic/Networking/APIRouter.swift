//
//  APIRouter.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/9/24.
//

import Foundation
import Alamofire

enum APIRouter {
    case getUsers
    case getUserDetail(id: Int)
    case createUser(name: String, email: String)
    // 다른 엔드포인트들...
}

extension APIRouter: URLRequestConvertible {
    var baseURL: URL {
        return URL(string: "https://api.example.com")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers, .getUserDetail:
            return .get
        case .createUser:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getUserDetail(let id):
            return "/users/\(id)"
        case .createUser:
            return "/users"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getUsers, .getUserDetail:
            return nil
        case .createUser(let name, let email):
            return ["name": name, "email": email]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        if let parameters = parameters {
            request = try URLEncoding.default.encode(request, with: parameters)
        }
        
        return request
    }
}
