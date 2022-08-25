//
//  View+renderAsImage.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/26.
//

import SwiftUI

extension View {
    func renderAsImage() -> CGImage? {
        let view = NoInsetHostingView(rootView: self)
        view.setFrameSize(view.fittingSize)
        return view.bitmapImage()
    }
}
