//
//  BoringAvatarModel.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/25.
//

import SwiftUI

struct BoringAvatarModel {
    var name: String
    var variant: Variant
    var size: Int
    var colours: Five<Color>

    enum Variant: String, CaseIterable {
        case beam, pixel, sunset, ring, bauhaus
    }

    var url: URL? {
        let colours = colours
            .map { first, second, third, fourth, fifth in
                [
                    first.convertToHex(),
                    second.convertToHex(),
                    third.convertToHex(),
                    fourth.convertToHex(),
                    fifth.convertToHex(),
                ]
                .compactMap { $0 }
                .joined(separator: ",")
            }

        guard let nameQuery = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let coloursQuery = colours.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return nil
        }

        return URL(string: "https://source.boringavatars.com/\(variant.rawValue)/\(size)/\(nameQuery)?colors=\(coloursQuery)")
    }
}