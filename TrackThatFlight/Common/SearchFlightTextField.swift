//
//  SearchFlightTextField.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 18/02/24.
//

import SwiftUI

struct SearchFlightTextField: View {
    @FocusState var isTextFieldActive: Bool
    @Environment(\.colorScheme) var colorScheme
    @Binding var input: String
    var isTextFieldDisable: Bool = false
    var withBorder: Bool = true
    var tapGesture: () -> Void
    
    var body: some View {
        if isTextFieldDisable {
            textField
                .onTapGesture {
                    tapGesture()
                }
        }
        else {
            textField
        }
    }
    
    var textField: some View {
        HStack(spacing: 8.0) {
            
            Image(systemName: "magnifyingglass")
            
            TextField(text: $input) {
                Text("Search Flight or Airports")
            }
            .focused($isTextFieldActive)
            .disabled(isTextFieldDisable)
            .padding(.horizontal, 4.0)
            .tint(AppColor.ff8000)
        }
        .padding(8.0)
        .background(
            RoundedRectangle(cornerRadius: 100.0)
                .stroke(AppColor.ff8000.opacity(withBorder ? 1.0 : 0.0), lineWidth: 1.0)
                .background(
                    RoundedRectangle(cornerRadius: 100.0)
                        .foregroundStyle(colorScheme == .dark ? .black : .white)
                )
        )
        .onAppear {
            isTextFieldActive = true
        }
    }
}

#Preview {
    SearchFlightTextField(input: .constant(""), tapGesture: {})
}
