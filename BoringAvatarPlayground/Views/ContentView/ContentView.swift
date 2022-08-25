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

            if let url = viewModel.request?.url {
                HStack {
                    Button("Copy URL") {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(url.absoluteString, forType: .string)
                    }
                    Button("Save Image") {
                        let view = createImageView(from: url)
                        let image = view.renderAsImage()

                        showSavePanel { url in
                            save(image: image, to: url)
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

    private func save(image: CGImage?, to file: URL?) {
        guard let image = image, let file = file else { return }
        guard let destination = CGImageDestinationCreateWithURL(
            file as CFURL,
            UTType.png.identifier as CFString, 1,
            nil
        ) else {
            return
        }
        CGImageDestinationAddImage(destination, image, nil)
        CGImageDestinationFinalize(destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
