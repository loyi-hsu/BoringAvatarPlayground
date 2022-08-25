//
//  ContentView.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/25.
//

import Combine
import SVGView
import SwiftUI

struct ContentView: View {
    typealias Variant = BoringAvatarModel.Variant

    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            ControlPanelView(viewModel: viewModel.controlPanelViewModel)
            Group {
                if let request = viewModel.request, let url = request.url {
                    SVGView(contentsOf: url)
                } else {
                    Rectangle()
                }
            }
            .frame(width: 200, height: 200, alignment: .center)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
