//
//  HomeView.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 17/02/24.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @State var showSearchScreen: Bool = false
    @State var goToAirportView: Bool = false
    @State var region = MKCoordinateRegion(
        center: .init(latitude: 37.334_900,longitude: -122.009_020),
        span: .init(latitudeDelta: 1, longitudeDelta: 1)
    )
    @State var airportCode: String = ""
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    var body: some View {
        VStack {
            
            //            Map {
            //                Marker("Latvian Freedom Monument", coordinate: .marker)
            //                MapPin(coordinate: $0.coordinate)
            //                Annotation(viewModel.flightNumber, coordinate: viewModel.flightMark) {
            //                    Image(systemName: "airplane")
            //                        .resizable()
            //                        .aspectRatio(contentMode: .fit)
            //                        .foregroundColor(AppColor.ff8000)
            //                        .frame(height: 24.0)
            //                }
            //            }
            //            .mapControlVisibility(.hidden)
            MyMapView(location: $viewModel.flightMark)
                .ignoresSafeArea(.all)
            
            
        }
        .navigationDestination(isPresented: $goToAirportView) {
            AirportDetailView(airportCode: airportCode)
        }
        .overlay() {
            VStack {
                SearchFlightTextField(input: .constant(viewModel.flightNumber), isTextFieldDisable: true, withBorder: false) {
                    showSearchScreen.toggle()
                }
                
                
                Spacer()
            }
            .padding(.horizontal, 8.0)

        }
        .overlay() {
            HomeViewBottomTray()
                .environmentObject(viewModel)
        }
        .fullScreenCover(isPresented: $showSearchScreen, content: {
            SearchFlightView(isSheetPresented: $showSearchScreen) { cellType, id, flightNumber in
                if cellType == .airport {
                    self.airportCode = id
                    goToAirportView.toggle()
                }
                else {
                    viewModel.getFlightData(id: id, flightNumber: flightNumber)
                }
            }
        })
    }
}

#Preview {
    HomeView()
}
