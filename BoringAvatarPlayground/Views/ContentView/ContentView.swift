//
//  ContentView.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/25.
//

import Combine
import SVGView
import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    typealias Variant = BoringAvatarModel.Variant

    @StateObject var viewModel = ContentViewModel()

    func createImageView(from url: URL) -> some View {
        SVGView(contentsOf: url)
    }

    var body: some View {
        VStack {
            ControlPanelView(viewModel: viewModel.controlPanelViewModel)
            Group {
                if let request = viewModel.request, let url = request.url {
                    createImageView(from: url)
                } else {
                    Rectangle()
                }
            }
            .frame(width: 200, height: 200, alignment: .center)

            if let request = viewModel.request,
               let url = request.url,
               !request.name.isEmpty
            {
                HStack {
                    Button("Copy URL") {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(url.absoluteString, forType: .string)
                    }
                    Button("Save Image") {
                        let view = createImageView(from: url)
                        let image = view.renderAsImage(size: viewModel.size ?? 500)

                        showSavePanel { url in
                            image?.save(to: url)
                        }
                    }
                }
            }
        }
        .padding()
    }

    func showSavePanel(closure: (URL?) -> Void) {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.png]
        savePanel.canCreateDirectories = true
        savePanel.isExtensionHidden = false
        savePanel.allowsOtherFileTypes = false
        savePanel.title = "Save your profile photo"
        savePanel.nameFieldLabel = "File name:"
        let response = savePanel.runModal()
        if response == .OK {
            closure(savePanel.url)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
