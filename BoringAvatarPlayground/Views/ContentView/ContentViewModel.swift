//
//  ContentViewModel.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/25.
//

import Cocoa
import Combine
import UniformTypeIdentifiers

class ContentViewModel: ObservableObject {
    let controlPanelViewModel = ControlPanelViewModel()

    var cancellables = Set<AnyCancellable>()

    @Published var request: BoringAvatarModel?
    @Published var selectedShape: Shape = .square
    @Published var selectedOutputType: AcceptedOutputTypes = .png

    init() {
        controlPanelViewModel
            .$request
            .sink { [weak self] newValue in
                self?.request = newValue
            }
            .store(in: &cancellables)
    }
}

extension ContentViewModel {
    enum Shape: String, CaseIterable {
        case square = "Square", roundedSquare = "Rounded Square", round = "Round"

        func getCornerRadius(size: CGFloat) -> CGFloat {
            if let divisor = divisor {
                return size / divisor
            } else {
                return 0
            }
        }

        private var divisor: CGFloat? {
            switch self {
            case .round: return 2
            case .roundedSquare: return 4
            case .square: return nil
            }
        }
    }
}

extension ContentViewModel {
    enum AcceptedOutputTypes: String, CaseIterable {
        case jpeg, png

        func convertToUTType() -> UTType {
            switch self {
            case .jpeg:
                return .jpeg
            case .png:
                return .png
            }
        }

        func convertToNSBitmapImageRepFileType() -> NSBitmapImageRep.FileType {
            switch self {
            case .jpeg:
                return .jpeg
            case .png:
                return .png
            }
        }
    }
}
