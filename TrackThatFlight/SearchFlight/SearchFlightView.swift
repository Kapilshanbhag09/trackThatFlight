//
//  SearchFlightView.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 17/02/24.
//

import SwiftUI

struct SearchFlightView: View {
    let cellWidht: CGFloat = (UIScreen.main.bounds.width - 32 - 32) / 2.0
    @Binding var isSheetPresented: Bool
    var cellTapped: (String, String) -> Void
    
    @ObservedObject var viewModel: SearchFlightViewModel = SearchFlightViewModel()
    var body: some View {
        VStack {
            HStack(spacing: 8.0) {
                SearchFlightTextField(input: $viewModel.searchQuery, withBorder: true) {}
                    .onChange(of: viewModel.searchQuery) {newValue in
                        
                    }
                    .onReceive(viewModel.$searchQuery, perform: { _ in
                        if viewModel.searchQuery.count >= 3 {
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
            
            ScrollView(showsIndicators: false) {
                if viewModel.searchResult.count > 0 {
                    ForEach(0...(viewModel.count % 2 != 0 ? (viewModel.count / 2) : (viewModel.count / 2) - 1), id: \.self) {index in
                        HStack {
                            SearchFlightCellView(name: viewModel.searchResult[(index * 2)].detail?.flight ?? "", src: viewModel.searchResult[(index * 2)].detail?.schd_from ?? "", dest: viewModel.searchResult[(index * 2)].detail?.schd_to ?? "", imageURL: viewModel.searchResult[(index * 2)].detail?.logo ?? "")
                                .frame(width: cellWidht)
                                .onTapGesture {
                                    isSheetPresented.toggle()
                                    cellTapped(viewModel.searchResult[index * 2].id ?? "", viewModel.searchResult[(index * 2)].detail?.flight ?? "")
                                }
                            Spacer()
                                .frame(maxWidth: 32.0)
                            
                            if (index * 2) + 1 < viewModel.count {
                                SearchFlightCellView(name: viewModel.searchResult[(index * 2) + 1].detail?.flight ?? "", src: viewModel.searchResult[(index * 2) + 1].detail?.schd_from ?? "", dest: viewModel.searchResult[(index * 2) + 1].detail?.schd_to ?? "", imageURL: viewModel.searchResult[(index * 2) + 1].detail?.logo ?? "")
                                    .frame(width: cellWidht)
                                    .onTapGesture {
                                        isSheetPresented.toggle()
                                        cellTapped(viewModel.searchResult[(index * 2) + 1].id ?? "", viewModel.searchResult[(index * 2) + 1].detail?.flight ?? "")
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
}

#Preview {
    SearchFlightView(isSheetPresented: .constant(false)) {_, _ in
        
    }
}
