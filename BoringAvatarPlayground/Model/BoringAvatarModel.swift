//
//  BoringAvatarModel.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/25.
//

import SwiftUI

struct BoringAvatarModel {
    var name: String
    var size: Int?
    var variant: Variant
    var colours: Five<Color>

    enum Variant: String, CaseIterable {
        case beam, pixel, sunset, ring, bauhaus
    }

    var url: URL? {
        let colours = colours.toArray()
            .compactMap { $0.convertToHex() }
            .joined(separator: ",")

        guard let nameQuery = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let coloursQuery = colours.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return nil
        }

        return URL(string: "https://source.boringavatars.com/\(variant.rawValue)/\(size ?? 1000)/\(nameQuery)?colors=\(coloursQuery)")
    }
}
