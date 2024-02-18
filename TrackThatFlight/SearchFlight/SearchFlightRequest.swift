//
//  SearchFlightRequest.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 17/02/24.
//

import Foundation

struct SearchFlightRequest: NetworkRequest {
    var baseURL: String = "https://www.flightradar24.com/"
    
    var endPoint: String = "v1/search/web/find"
    
    var queryParams: [String : Any] = [:]
    
    var body: [String : Any] = [:]
    
    var method: RequestMethod = .get
    
    init(searchQuery: String, limit: Int = 10) {
        queryParams["query"] = searchQuery
        queryParams["limit"] = limit
    }
}
