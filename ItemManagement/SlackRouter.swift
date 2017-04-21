//
//  SlackAPIRouter.swift
//  ItemManagement
//
//  Created by maekawakazuma on 2017/03/22.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import Foundation
import Alamofire

enum SlackRouter: URLRequestConvertible {
    case getUser()

    
    static let baseURLString = "https://slack.com/api"
    static let token = "xoxp-3241757266-4596903960-163198099059-d89ec1cbf6b9632947331c42dc7a9054"
    

    /*
     {
     "ok": true,
     "access_token": "xoxp-3241757266-4596903960-163198099059-d89ec1cbf6b9632947331c42dc7a9054",
     "scope": "identify,users:read",
     "user_id": "U04HJSKU8",
     "team_name": "P&D",
     "team_id": "T0373N97U"
     }
     */
    
    
    var method: HTTPMethod {
        switch self {
        case .getUser:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getUser:
            return "/users.list"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try SlackRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getUser():
            urlRequest = try URLEncoding.default.encode(urlRequest, with: ["token":SlackRouter.token])
        }
        
        return urlRequest
    }
}

