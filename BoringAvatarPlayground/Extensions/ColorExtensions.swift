//
//  ColorExtensions.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/25.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        Color(
            .sRGB,
            red: .random(in: 0 ..< 1),
            green: .random(in: 0 ..< 1),
            blue: .random(in: 0 ..< 1),
            opacity: 1.0
        )
    }

    func convertToHex() -> String? {
        guard let cgColor = cgColor else { return nil }
        guard let components = cgColor.components else { return nil }
        guard components.count > 3 else { return nil }
        let colour = components[0 ..< 3]
            .compactMap {
                Int(ceil($0 * 255))
            }
            .map {
                String($0, radix: 16, uppercase: true)
            }
            .joined()
        return "#\(colour)"
    }
}
