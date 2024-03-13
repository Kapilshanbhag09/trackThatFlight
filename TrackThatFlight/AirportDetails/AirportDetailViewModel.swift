//
//  AirportDetailViewModel.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 18/02/24.
//

import Foundation


class AirportDetailViewModel: ObservableObject {
    @Published var airportCode: String
    @Published var airportDetails: AirportDetailModel = AirportDetailModel()
    
    init(airportCode: String) {
        self.airportCode = airportCode
    }
    
    func getAirportDetail() {
        let request = AirportDetailRequest(airportCode: self.airportCode)
        
        NetworkCall.loadRequest(AirportDetailResponseModel.self, request: request) {data, error in
            DispatchQueue.main.async {
                guard let data = data?.data else {return}
                self.airportDetails = data
            }
        }
    }
}
