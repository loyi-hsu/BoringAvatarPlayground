//
//  NoInsetHostingView.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/26.
//

import SwiftUI

class NoInsetHostingView<V>: NSHostingView<V> where V: View {
    override var safeAreaInsets: NSEdgeInsets {
        return .init()
    }
}
