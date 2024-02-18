//
//  SearchFlightViewModel.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 17/02/24.
//

import Foundation

class SearchFlightViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var searchResult: [SearchFlightResultModel] = []
    @Published var searchAirportResult: [SearchFlightResultModel] = []
    @Published var flightName: String = ""
    var count: Int = 0
    
    func searchFlightFromNetwork() {
        let request = SearchFlightRequest(searchQuery: searchQuery, limit: 50)
        NetworkCall.loadRequest(SearchFlightResponseModel.self, request: request) { [weak self] response, error in
            if let _ = error {
                return
            }
            
            self?.filterLiveResult(result: response?.results)
        }
        
    }
    
    func filterLiveResult(result: [SearchFlightResultModel]?) {
        guard let result = result else {return}
        DispatchQueue.main.async { [weak self] in
            self?.searchResult = result.compactMap({$0.type == SearchType.live.rawValue ? $0 : nil})
            self?.searchAirportResult = result.compactMap({$0.type == SearchType.airport.rawValue ? $0 : nil})
            self?.count = self?.searchResult.count ?? 0
            print(self?.searchResult)
            print(self?.searchAirportResult)
        }
        
    }
}
