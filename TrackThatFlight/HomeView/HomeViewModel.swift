//
//  HomeViewModel.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 17/02/24.
//

import Foundation
import MapKit

class HomeViewModel: ObservableObject {
    @Published var flightData: HomeViewFlightDataResponseModel?
    @Published var flightNumber: String = ""
    @Published var flightMark = CLLocationCoordinate2D(latitude: 37.334_900, longitude: -122.009_020)
    @Published var isAPILoading: Bool = false
    @Published var location = [CLLocation(latitude: 37.334_900, longitude: -122.009_020)]
    
    func getFlightData(id: String, flightNumber: String) {
        let networkRequest = HomeViewFlightRequest(flightID: id)
        isAPILoading = true
        NetworkCall.loadRequest(HomeViewFlightDataResponseModel.self, request: networkRequest) { [weak self] data, error in
            DispatchQueue.main.async {
                self?.flightData = data
                self?.flightNumber = flightNumber
                self?.flightMark = CLLocationCoordinate2D(latitude: data?.trail?[0].lat ?? 0.0, longitude: data?.trail?[0].lng ?? 0.0)
                self?.isAPILoading = false
            }
        }
    }
}
