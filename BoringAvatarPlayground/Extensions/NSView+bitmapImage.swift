//
//  NSView+bitmapImage.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/26.
//

import Cocoa

extension NSView {
    func bitmapImage() -> CGImage? {
        guard let rep = bitmapImageRepForCachingDisplay(in: bounds) else {
            return nil
        }
        cacheDisplay(in: bounds, to: rep)
        return rep.cgImage
    }
}
