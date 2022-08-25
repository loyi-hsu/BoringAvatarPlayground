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

    func map<U>(closure: @escaping (T, T, T, T, T) -> U) -> U {
        return closure(first, second, third, fourth, fifth)
    }
}
