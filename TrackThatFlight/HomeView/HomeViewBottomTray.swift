//
//  HomeViewBottomTray.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 17/02/24.
//

import SwiftUI

struct HomeViewBottomTray: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: HomeViewModel
    @State var windowSize: CGFloat = 100.0
    var screenWidth: CGFloat = {
        UIScreen.main.bounds.width
    }()
    var maxWindowSize: CGFloat = UIScreen.main.bounds.height - 24 - (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0)
    @State var isTrayOpen: Bool = false
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 0.0) {
                topRectangle
                
                Spacer()
                    .frame(height: 16.0)
                
                VStack(spacing: 0.0) {
                    flightNumber
                    
                    airlineName
                }
                .overlay() {
                    HStack {
                        Spacer()
                        
                        if !viewModel.isAPILoading {
                            Button(action: {
                                viewModel.getFlightData(id: viewModel.flightData?.identification?.id ?? "", flightNumber: viewModel.flightNumber)
                            }) {
                                Image(systemName: "arrow.clockwise")
                                    .foregroundStyle(AppColor.ff8000)
                            }
                        }
                        else {
                            ProgressView()
                                .tint(AppColor.ff8000)
                        }
                    }
                    .padding(.horizontal, 16.0)
                }
                
                if windowSize > 100.0 {
                    ScrollView {
                        VStack(spacing: 0.0) {
                            orangeDivider
                            
                            airplaneModel
                            
                            orangeDivider
                        }
                    }
                }
                
                
                
                
                
                Spacer()
            }
            .padding(.top, 8.0)
            .gesture(
                dragGesture
            )
            
            
            .background(
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundColor( colorScheme == .light ? .white : .black)
            )
            .ignoresSafeArea(.all, edges: .bottom)
            .frame(height: windowSize)
        }
    }
    //MARK: topRectangle
    var topRectangle: some View {
        HStack {
            Spacer()
            
            RoundedRectangle(cornerRadius: 12.0)
                .frame(width: 54.0, height: 4)
                .foregroundColor(AppColor.dbdce0)
            
            Spacer()
        }
    }
    //MARK: flightNumber
    var flightNumber: some View {
        HStack {
            Spacer()
            
            Text(viewModel.flightNumber)
                .foregroundStyle(AppColor.ff8000)
                .font(.system(size: 22.0, weight: .bold))
            
            Spacer()
        }
    }
    
    //MARK: airlineName
    var airlineName: some View {
        Text(viewModel.flightData?.airline?.name ?? "")
            .font(.system(size: 17.0, weight: .medium))
            .padding(.bottom, 16.0)
    }
    
    //MARK: dragGesture
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged {
                let change = $0.startLocation.y - $0.location.y
                if windowSize >= 100.0 {
                    windowSize += change
                }
            }
            .onEnded {
                let change = $0.startLocation.y - $0.location.y
                if isTrayOpen {
                    windowSize <= maxWindowSize - 100 ? closeTray() : openTray()
                }
                else {
                    windowSize >= 200 ? openTray() : closeTray()
                }
            }
    }
    //MARK: orangeDivider
    var orangeDivider: some View {
        Rectangle()
            .frame(height: 4.0)
            .foregroundColor(AppColor.ff8000.opacity(0.33))
    }
    //MARK: airplaneModel
    var airplaneModel: some View  {
        VStack(alignment: .leading, spacing: 0.0) {
            HStack {Spacer()}
            Group {
                Text("Aircraft Type ")
                    .font(.system(size: 15.0))
                +
                Text(viewModel.flightData?.aircraft?.model?.code ?? "-")
                    .font(.system(size: 15.0, weight: .medium))
            }
            
            Spacer()
                .frame(height: 8.0)
            
            Text(viewModel.flightData?.aircraft?.model?.text ?? "-")
                .font(.system(size: 15.0, weight: .medium))
            
            Spacer()
                .frame(height: 16.0)
            
            AsyncImage(url: URL(string: viewModel.flightData?.aircraft?.images?.large?[0].src ?? (viewModel.flightData?.aircraft?.images?.medium?[0].src ?? "")), content: { image in
                image
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth - 32)
                
            }) {
                EmptyView()
            }
            
            
        }
        .padding(16.0)
        
    }
    
    func openTray() {
        withAnimation(.easeIn(duration: 0.2)) {
            windowSize = maxWindowSize
            isTrayOpen = true
        }
    }
    
    func closeTray() {
        withAnimation(.easeIn(duration: 0.2)) {
            windowSize = 100.0
            isTrayOpen = false
        }
    }
}

#Preview {
    HomeViewBottomTray()
        .environmentObject(HomeViewModel())
}
