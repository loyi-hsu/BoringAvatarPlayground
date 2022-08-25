//
//  CGImage+save.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/26.
//

import Cocoa
import UniformTypeIdentifiers

extension CGImage {
    func save(to file: URL?) {
        guard let file = file else { return }
        guard let destination = CGImageDestinationCreateWithURL(
            file as CFURL,
            UTType.png.identifier as CFString, 1,
            nil
        ) else {
            return
        }
        CGImageDestinationAddImage(destination, self, nil)
        CGImageDestinationFinalize(destination)
    }
}
