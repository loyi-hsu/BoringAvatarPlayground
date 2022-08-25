//
//  ControlPanelViewModel.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/25.
//

import Combine
import SwiftUI

class ControlPanelViewModel: ObservableObject {
    typealias Variant = BoringAvatarModel.Variant

    @Published var request: BoringAvatarModel?

    @Published var name = ""
    @Published var selectedVariant: String = "beam"
    @Published var size = "500" {
        willSet(newValue) {
            if Int(newValue) != nil {
                size = newValue
            }
        }
    }

    @Published var colours = [
        Color.random(),
        Color.random(),
        Color.random(),
        Color.random(),
        Color.random(),
    ]

    var cancellables = Set<AnyCancellable>()

    init() {
        Publishers.CombineLatest3(
            $name,
            $selectedVariant,
            $colours
        )
        .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
        .sink { [weak self] _ in
            self?.request = self?.updatePreview()
        }
        .store(in: &cancellables)
    }

    func refreshColours() {
        colours = [
            Color.random(),
            Color.random(),
            Color.random(),
            Color.random(),
            Color.random(),
        ]
    }

    private func updatePreview() -> BoringAvatarModel? {
        guard let selectedVariant = Variant(rawValue: selectedVariant),
              let size = Int(size)
        else {
            return nil
        }
        return BoringAvatarModel(
            name: name,
            variant: selectedVariant,
            size: size,
            colours: Five<Color>(
                first: colours[0],
                second: colours[1],
                third: colours[2],
                fourth: colours[3],
                fifth: colours[4]
            )
        )
    }
}
