//
//  APIRouter.swift
//  TCACoordinators_Basic
//
//  Created by psynet on 7/9/24.
//

import Foundation
import Alamofire

enum APIRouter {
    // 연습용
    case getUsers
    case getUserDetail(id: Int)
    case createUser(name: String, email: String)
    // 사용
    case gitSearch(txt: String)
}

extension APIRouter: URLRequestConvertible {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers, .getUserDetail, .gitSearch:
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
        case .gitSearch(let txt):
            return "/search/repositories"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getUsers, .getUserDetail:
            return nil
        case .createUser(let name, let email):
            return ["name": name, "email": email]
        case .gitSearch(let txt):
            return ["q": txt]
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
