//
//  AirportDetailModel.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 18/02/24.
//

import Foundation


struct AirportDetailResponseModel: Codable {
    var data: AirportDetailModel?
}

struct AirportDetailModel: Codable {
    var airport : AirportDetailAirportModel?
    var arrivals : AirportDetailArrivalsModel?
    var departures : AirportDetailDeparturesModel?
}

struct AirportDetailAirportModel: Codable {
    var name        : String?
    var city        : String?
    var latitude    : Double?
    var longitude   : Double?
}

struct AirportDetailArrivalsModel: Codable {
    
}

struct AirportDetailDeparturesModel: Codable {
    
}
    
