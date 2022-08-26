//
//  View+renderAsImage.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/26.
//

import SwiftUI

extension View {
    func renderAsImage(size: Int) -> NSImage? {
        let view = NoInsetHostingView(rootView: self)
        view.setFrameSize(NSSize(width: size, height: size))
        return view.bitmapImage()
    }
}
