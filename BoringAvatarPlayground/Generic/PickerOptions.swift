//
//  PickerOptions.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/25.
//

import Foundation

struct PickerOptions<T: Hashable>: Identifiable, Hashable, Equatable {
    static func == (lhs: PickerOptions<T>, rhs: PickerOptions<T>) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(content)
    }

    let id = UUID()
    let content: T
}
