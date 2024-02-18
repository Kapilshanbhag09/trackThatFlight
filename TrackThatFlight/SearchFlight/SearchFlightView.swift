//
//  SearchFlightView.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 17/02/24.
//

import SwiftUI

struct SearchFlightView: View {
    @Environment(\.colorScheme) var colorScheme
    let cellWidht: CGFloat = (UIScreen.main.bounds.width - 32 - 32) / 2.0
    @Binding var isSheetPresented: Bool
    var cellTapped: (SearchType,String, String) -> Void
    
    @ObservedObject var viewModel: SearchFlightViewModel = SearchFlightViewModel()
    var body: some View {
        VStack(spacing: 16.0) {
            searchTextField
            
            if viewModel.searchAirportResult.count > 0 {
                airportResult
            }
            
            ScrollView(showsIndicators: false) {
                if viewModel.searchResult.count > 0 {
                    ForEach(0...(viewModel.count % 2 != 0 ? (viewModel.count / 2) : (viewModel.count / 2) - 1), id: \.self) {index in
                        HStack {
                            SearchFlightCellView(name: viewModel.searchResult[(index * 2)].detail?.flight ?? "", src: viewModel.searchResult[(index * 2)].detail?.schd_from ?? "", dest: viewModel.searchResult[(index * 2)].detail?.schd_to ?? "", imageURL: viewModel.searchResult[(index * 2)].detail?.logo ?? "")
                                .frame(width: cellWidht)
                                .onTapGesture {
                                    isSheetPresented.toggle()
                                    cellTapped(.live, viewModel.searchResult[index * 2].id ?? "", viewModel.searchResult[(index * 2)].detail?.flight ?? "")
                                }
                            Spacer()
                                .frame(maxWidth: 32.0)
                            
                            if (index * 2) + 1 < viewModel.count {
                                SearchFlightCellView(name: viewModel.searchResult[(index * 2) + 1].detail?.flight ?? "", src: viewModel.searchResult[(index * 2) + 1].detail?.schd_from ?? "", dest: viewModel.searchResult[(index * 2) + 1].detail?.schd_to ?? "", imageURL: viewModel.searchResult[(index * 2) + 1].detail?.logo ?? "")
                                    .frame(width: cellWidht)
                                    .onTapGesture {
                                        isSheetPresented.toggle()
                                        cellTapped(.live, viewModel.searchResult[(index * 2) + 1].id ?? "", viewModel.searchResult[(index * 2) + 1].detail?.flight ?? "")
                                    }
                            }
                            else {
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 16.0)
                    }
                }
            }
        }
    }
    
    //MARK: searchTextField
    var searchTextField: some View {
        HStack(spacing: 8.0) {
            SearchFlightTextField(input: $viewModel.searchQuery, withBorder: true) {}
                .onChange(of: viewModel.searchQuery) {newValue in
                    
                }
                .onReceive(viewModel.$searchQuery.debounce(for: 0.7, scheduler: RunLoop.main), perform: { _ in
                    if viewModel.searchQuery.count >= 2 {
                        viewModel.searchFlightFromNetwork()
                    }
                })
            
            Button(action: {
                isSheetPresented.toggle()
            }
            ) {
                Text("Cancel")
                    .font(.system(size: 13.0, weight: .semibold))
                    .foregroundStyle(AppColor.ff8000)
            }
        }
        .padding(.horizontal, 16.0)
    }
    //MARK: airportResult
    var airportResult: some View {
        VStack(alignment: .leading) {
            Text("Airports")
                .font(.system(size: 15.0, weight: .medium))
                .padding(.horizontal, 16.0)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<viewModel.searchAirportResult.count) { index in
                        Button(action: {
                            self.isSheetPresented.toggle()
                            self.cellTapped(.airport, viewModel.searchAirportResult[index].id ?? "", "")
                        }) {
                            Text(viewModel.searchAirportResult[index].id ?? "")
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .font(.system(size: 15.0, weight: .bold))
                                .padding(8.0)
                                .background(
                                    RoundedRectangle(cornerRadius: 8.0)
                                        .stroke(AppColor.ff8000.opacity(0.3), lineWidth: 1.0)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8.0)
                                                .foregroundStyle(.white)
                                        )
                                )
                        }
                    }
                }
                .padding(.horizontal, 16.0)
            }
        }
    }
}

#Preview {
    SearchFlightView(isSheetPresented: .constant(false)) {_, _,_  in
        
    }
}
