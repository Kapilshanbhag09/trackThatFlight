//
//  AirportDetailView.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 18/02/24.
//

import SwiftUI

struct AirportDetailView: View {
    var airportCode: String
    var body: some View {
        Text(airportCode)
    }
}

#Preview {
    AirportDetailView(airportCode: "HYD")
}
