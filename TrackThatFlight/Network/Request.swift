//
//  Request.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 17/02/24.
//

import Foundation

protocol NetworkRequest {
    var baseURL: String {get set}
    var endPoint: String {get set}
    var queryParams: [String : Any] {get set}
    var body: [String: Any] {get set}
    var method: RequestMethod {get set}
}

enum RequestMethod: String {
    case get
    case post
}

struct NetworkError {
    var code: Int
    var errorMsg: String
}
