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

    let shapeOptions = ContentViewModel.Shape.allCases.map(PickerOptions.init)

    var body: some View {
        VStack {
            ControlPanelView(viewModel: viewModel.controlPanelViewModel)
            if let (_, url) = requestUrlIfIsValidImage {
                Button("Copy URL") {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(url.absoluteString, forType: .string)
                }
            }
            Group {
                if let request = viewModel.request, let url = request.url {
                    createImageView(from: url)
                } else {
                    Rectangle()
                }
            }
            .frame(width: 200, height: 200, alignment: .center)
            .cornerRadius(
                viewModel
                    .selectedShape
                    .getCornerRadius(size: 200)
            )

            if let (request, url) = requestUrlIfIsValidImage {
                HStack {
                    Picker("Shape", selection: $viewModel.selectedShape) {
                        ForEach(shapeOptions) { option in
                            Text(option.content.rawValue).tag(option.content)
                        }
                    }
                    Button("Save Image") {
                        let view = createImageView(from: url)
                            .cornerRadius(
                                viewModel
                                    .selectedShape
                                    .getCornerRadius(size: CGFloat(request.size))
                            )
                        let image = view.renderAsImage(size: request.size)

                        showSavePanel { url in
                            image?.save(to: url)
                        }
                    }
                }
            }
        }
        .padding()
    }

    private func showSavePanel(closure: (URL?) -> Void) {
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

    private var requestUrlIfIsValidImage: (BoringAvatarModel, URL)? {
        guard let request = viewModel.request, let url = request.url else {
            return nil
        }
        return !request.name.isEmpty ? (request, url) : nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
