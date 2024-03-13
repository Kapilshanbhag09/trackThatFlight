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
    
    func getCountryName() -> String? {
        self.airport?.country?.name?.capitalized(with: nil)
    }
    func getFlagLink() -> String {
        if var country = self.airport?.country?.name?.lowercased() {
            country = country.replacingOccurrences(of: " ", with: "-")
            return "https://www.flightradar24.com/static/mapapp/24.064.1029.307a607/assets/images/general/flags-small/"+country+".svg"
        }
        return ""
    }
}

struct AirportDetailAirportModel: Codable {
    var name        : String?
    var city        : String?
    var latitude    : Double?
    var longitude   : Double?
    var country     : AirportCountryModel?
    
    struct AirportCountryModel: Codable {
        var name    : String?
    }
}


struct AirportDetailArrivalsModel: Codable {
    
}

struct AirportDetailDeparturesModel: Codable {
    
}
    
