//
//  Color.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 17/02/24.
//

import Foundation
import SwiftUI

enum AppColor {
    
    static var ff8000 = Color(hex: 0xFF8000) // Orange
    static var dbdce0   = Color(hex: 0xDBDCE0)
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
