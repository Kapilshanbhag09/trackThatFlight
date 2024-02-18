//
//  AirportDetailView.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 18/02/24.
//

import SwiftUI

struct AirportDetailView: View {
    @ObservedObject var viewModel: AirportDetailViewModel
    
    init(airportCode: String) {
        self.viewModel = AirportDetailViewModel(airportCode: airportCode)
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(viewModel.airportDetails.airport?.name ?? "")
                    .padding(.horizontal, 16.0)
                
                HStack {
                    Spacer()
                }
                Spacer()
            }
        }
        .navigationTitle(viewModel.airportCode)
        .onAppear {
            viewModel.getAirportDetail()
        }
    }
}

#Preview {
    AirportDetailView(airportCode: "HYD")
}
