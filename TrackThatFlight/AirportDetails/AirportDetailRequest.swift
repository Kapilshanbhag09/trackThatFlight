//
//  AirportDetailRequest.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 18/02/24.
//

import Foundation


struct AirportDetailRequest: NetworkRequest {
    var baseURL: String = "https://www.flightradar24.com/"
    
    var endPoint: String = "webapi/v1/airport-disruptions/"
    
    var queryParams: [String : Any] = [:]
    
    var body: [String : Any] = [:]
    
    var method: RequestMethod = .get
    
    init(airportCode: String) {
        endPoint.append(airportCode)
    }
}
