//
//  SearchFlightModel.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 17/02/24.
//

import Foundation
struct SearchFlightResponseModel: Codable {
    var results: [SearchFlightResultModel]?
}

struct SearchFlightResultModel: Codable {
    var id: String?
    var detail: SearchFlightDetailModel?
    var type: String?
}

struct SearchFlightDetailModel: Codable {
    var lat: Double?
    var lon: Double?
    var schd_from: String?
    var schd_to: String?
    var logo: String?
    var flight: String?
}
