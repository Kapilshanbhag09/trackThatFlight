//
//  HomeViewFlightRequest.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 17/02/24.
//

import Foundation


struct HomeViewFlightRequest: NetworkRequest {
    var baseURL: String = "https://data-live.flightradar24.com/"
    
    var endPoint: String = "clickhandler"
    
    var queryParams: [String : Any] = [:]
    
    var body: [String : Any] = [:]
    
    var method: RequestMethod = .get
    
    init(flightID: String) {
        queryParams["flight"] = flightID
        queryParams["version"] = 1.5
    }
}
