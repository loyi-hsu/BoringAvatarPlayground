//
//  Five.swift
//  BoringAvatarPlayground
//
//  Created by Loyi Hsu on 2022/8/25.
//

import Foundation

struct Five<T> {
    var first: T
    var second: T
    var third: T
    var fourth: T
    var fifth: T

    func toArray() -> [T] {
        [first, second, third, fourth, fifth]
    }
}
