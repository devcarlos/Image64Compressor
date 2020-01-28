//
//  ImageAsset.swift
//  Image64Compresor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.
//

import Foundation

struct ImageAsset {
    let name: String
    let key: String
    let base64: String
}

class PrintableImageAsset {

    class func templateItem(_ item: ImageAsset, _ projectName: String = "") -> String {
        return """
        public static let \(item.key) = \(projectName)ImageAsset(name: "\(item.name)", key: "\(item.key)")\n
        """
    }

    class func assetItem(_ item: ImageAsset) -> String {
        return """
        case \(item.key)\n
        """
    }

    class func assetsDictionary(_ items: [ImageAsset]) -> String {
        var values = items.map { "\"\($0.key)\": \"\($0.base64)\"" }
        for item in values.enumerated() {
            let separator = item.offset == values.count - 1 ? "" : ","
            values[item.offset].append(separator)
        }
        return values.joined(separator: "\n")
    }
}
