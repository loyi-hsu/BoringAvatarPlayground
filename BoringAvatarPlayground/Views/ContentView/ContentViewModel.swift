//
//  ContentViewModel.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/25.
//

import Combine

class ContentViewModel: ObservableObject {
    let controlPanelViewModel = ControlPanelViewModel()

    var cancellables = Set<AnyCancellable>()

    @Published var request: BoringAvatarModel?

    var size: Int?

    init() {
        controlPanelViewModel
            .$request
            .sink { [weak self] newValue in
                self?.request = newValue
            }
            .store(in: &cancellables)
    }
}
