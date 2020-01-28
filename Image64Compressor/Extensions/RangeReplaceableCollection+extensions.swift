//
//  RangeReplaceableCollection+extensions.swift
//  Image64Compressor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.

import Foundation

extension RangeReplaceableCollection where Self: StringProtocol {
    mutating func removeAllNonAlphanumericsCharacters() {
        removeAll { !($0.isNumber || $0.isLetter) }
    }
}
