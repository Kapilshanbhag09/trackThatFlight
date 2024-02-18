//
//  HomeViewFlightModel.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 17/02/24.
//

import Foundation

struct HomeViewFlightDataResponseModel: Codable {
    var identification  : HomeViewFlightDataIdentificationModel?
    var airline         : HomeViewFlightDataAirlineModel?
    var trail           : [HomeViewFlightTrailModel]?
    var aircraft        : HomeViewFlighAircraftModel?
            

}

struct HomeViewFlightDataIdentificationModel: Codable {
    var id          : String?
    var callsign    : String?
}
struct HomeViewFlightDataAirlineModel: Codable {
    var name: String?
    var url : String?
}

struct HomeViewFlightTrailModel: Codable {
    var lat : Double?
    var lng : Double?
    var alt : Int?
    var spd : Int?
    var ts  : Int?
    var hd  : Int?
}

struct HomeViewFlighAircraftModel: Codable {
    var model   : HomeViewFlighAircraftModelModel?
    var images  : HomeViewFlightAircraftImagesModel?
}
struct HomeViewFlighAircraftModelModel: Codable {
    var code    : String?
    var text    : String?
}

struct HomeViewFlightAircraftImagesModel: Codable {
    var medium  : [HomeViewFlightAircraftImagesMediumModel]?
    var large   : [HomeViewFlightAircraftImagesMediumModel]?
}

struct HomeViewFlightAircraftImagesMediumModel: Codable {
    var src: String?
}
            
