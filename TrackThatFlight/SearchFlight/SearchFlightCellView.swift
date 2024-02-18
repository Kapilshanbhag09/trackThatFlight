//
//  SearchFlightCellView.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 17/02/24.
//

import SwiftUI

struct SearchFlightCellView: View {
    var name: String
    var src: String
    var dest: String
    var imageURL: String
    var body: some View {
        VStack(spacing: 16.0) {
            asyncImage
            
            Text(name)
                .font(.system(size: 17.0, weight: .bold))
            
            srcDest
            
            liveTag
        }
        .padding(16.0)
        .overlay(
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(lineWidth: 1.0)
                .foregroundColor(AppColor.ff8000.opacity(0.08))
                .foregroundColor(.clear)
                .shadow(color: AppColor.ff8000.opacity(0.24), radius: 2.0, x: 0, y: 1)
        )
        
    }
}

extension SearchFlightCellView {
    //MARK: asyncImage
    var asyncImage: some View {
        AsyncImage(url: URL(string: imageURL), content: { image in
            image
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(height: 36.0)
            
        }) {
            EmptyView()
        }
    }
    
    //MARK: srcDest
    var srcDest: some View {
        HStack(spacing: 8.0) {
            Spacer ()
            
            Text(src)
                .font(.system(size: 13.0, weight: .medium))
            
            Image(systemName: "airplane.circle.fill")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(AppColor.ff8000)
                .frame(width: 24, height: 24)
            
            Text(dest)
                .font(.system(size: 13.0, weight: .medium))
            
            Spacer ()
        }
        .font(.system(size: 15.0, weight: .medium))
    }
    
    //MARK: live Tag
    var liveTag: some View {
        Text("LIVE •")
            .font(.system(size: 13.0, weight: .heavy))
            .padding(.horizontal, 8.0)
            .padding(.vertical, 4.0)
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundColor(.red)
            )
    }
}

#Preview {
    SearchFlightCellView(name: "IND110", src: "BOM", dest: "IXG",
                         imageURL: "https://images.flightradar24.com/assets/airlines/logotypes/31.png"
    )
}
