//
//  ControlPanelView.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/25.
//

import SwiftUI

struct ControlPanelView: View {
    typealias Variant = BoringAvatarModel.Variant

    @ObservedObject var viewModel: ControlPanelViewModel

    let variantOptions = Variant.allCases.map(PickerOptions.init)

    var body: some View {
        VStack {
            TextField("Name", text: $viewModel.name)

            Picker("Variant", selection: $viewModel.selectedVariant) {
                ForEach(variantOptions) { option in
                    Text(option.content.rawValue).tag(option.content.rawValue)
                }
            }

            TextField("Size", text: $viewModel.size)

            HStack {
                ColorPicker(selection: $viewModel.colours[0]) {
                    Text("First")
                }
                ColorPicker(selection: $viewModel.colours[1]) {
                    Text("Second")
                }
                ColorPicker(selection: $viewModel.colours[2]) {
                    Text("Third")
                }
                ColorPicker(selection: $viewModel.colours[3]) {
                    Text("Fourth")
                }
                ColorPicker(selection: $viewModel.colours[4]) {
                    Text("Fifth")
                }
            }

            Button("Randomise Colours Again") {
                viewModel.refreshColours()
            }
        }
    }
}
