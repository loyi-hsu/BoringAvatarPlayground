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
    let sizeOptions = (1 ... 10)
        .map { $0 * 100 }
        .map(PickerOptions.init)

    var body: some View {
        VStack {
            TextField("Name", text: $viewModel.name)

            VStack(alignment: .trailing) {
                Picker("Size", selection: $viewModel.size) {
                    ForEach(sizeOptions) { value in
                        Text("\(value.content)").tag(value.content)
                    }
                }

                Text("This value will be scaled up by 2 times on Retina Devices.")
                    .font(.caption)
            }

            Picker("Variant", selection: $viewModel.selectedVariant) {
                ForEach(variantOptions) { option in
                    Text(option.content.rawValue).tag(option.content.rawValue)
                }
            }

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
