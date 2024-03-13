//
//  AirportDetailView.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 18/02/24.
//

import SwiftUI

struct AirportDetailView: View {
    
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var viewModel: AirportDetailViewModel
    @State var tabSelection: AirportDetailTabs = .general
    
    @State var image: UIImage = UIImage()
    
    init(airportCode: String) {
        self.viewModel = AirportDetailViewModel(airportCode: airportCode)
    }
    var body: some View {
        VStack(alignment: .leading) {
            headerDetail
            
            TabView(selection: $tabSelection) {
                Text("Detail")
                    .onAppear() {
                        print("Detail Appeard")
                    }
                    .tag(AirportDetailTabs.general)
                
                Text("Arrival")
                    .onAppear() {
                        print("Detail Appeard")
                    }
                    .tag(AirportDetailTabs.arrival)
                
                Text("Departure")
                    .onAppear() {
                        print("Detail Appeard")
                    }
                    .tag(AirportDetailTabs.departure)
                
                Text("On Ground")
                    .onAppear() {
                        print("Detail Appeard")
                    }
                    .tag(AirportDetailTabs.onGround)
                
            }
            //                .tabViewStyle(.page(indexDisplayMode: .never))
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            bottomTab
            
        }
        .navigationTitle(viewModel.airportCode)
        .onAppear {
            viewModel.getAirportDetail()
        }
    }
    
    //MARK: headerDetail
    var headerDetail: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HStack {Spacer()}
            Text(viewModel.airportDetails.airport?.name ?? "")
            HStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50.0)
                    .onAppear {
                        guard let url = URL(string: viewModel.airportDetails.getFlagLink()) else {return}
                        UIImage.downloadedsvg(from: url) { image in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.image = image
                            }
                        }
                    }
                Text(viewModel.airportDetails.getCountryName() ?? "")
            }
        }
        .padding(.horizontal, 16.0)
    }
    
    //MARK: bottomTab
    var bottomTab: some View {
        HStack {
            ForEach(AirportDetailTabs.allCases) { tab in
                Spacer()
                VStack(spacing: 8.0) {
                    Image(systemName: tab.tabDisplayImage)
                        .foregroundStyle(tab == tabSelection ? AppColor.ff8000 : colorScheme == .dark ? .white : .black)
                
                    Text(tab.tabDisplayName)
                        .font(.system(size: 13.0, weight: .medium))
                        .foregroundStyle(tab == tabSelection ? AppColor.ff8000 : colorScheme == .dark ? .white : .black)
                }
                .onTapGesture {
                    tabSelection = tab
                }
                Spacer()
            }
        }
    }
    
    //MARK: AirportDetailTabs(E)
    enum AirportDetailTabs: Int, CaseIterable, Identifiable {
        var id: UUID {
            return UUID()
        }
        
        case general
        case arrival
        case departure
        case onGround
        
        var tabDisplayName: String {
            switch self {
            case .general: return "General"
            case .arrival: return "Arrival"
            case .departure: return "Departure"
            case .onGround: return "On Ground"
            }
        }
        
        var tabDisplayImage: String {
            switch self {
            case .general: return "info.circle"
            case .arrival: return "airplane.arrival"
            case .departure: return "airplane.departure"
            case .onGround: return "airplane.circle"
            }
        }
    }
}

#Preview {
    AirportDetailView(airportCode: "HYD")
}
