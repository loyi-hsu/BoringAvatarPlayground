//
//  NSImage+save.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/26.
//

import Cocoa

extension NSImage {
    func save(to file: URL?, fileType: NSBitmapImageRep.FileType) {
        guard let data = tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: data),
              let representation = bitmap.representation(using: fileType, properties: [.compressionFactor: 1.0]),
              let file = file
        else { return }

        try? representation.write(to: file)
    }
}
