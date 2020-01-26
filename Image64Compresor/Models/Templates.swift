//
//  Templates.swift
//  Image64Compresor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.
//

import Foundation

let AssetTemplate = """

import UIKit


public typealias AssetImageTypeAlias = UIImage
public typealias AssetDataTypeAlias = Data

public struct ImageAsset {
    public let name: String
    public let key: String

    public var image: AssetImageTypeAlias {
        return ImageAssets.imageFromString(key) ?? UIImage()
    }

    public var data: AssetDataTypeAlias {
        return ImageAssets.dataFromString(key) ?? Data()
    }
}

public enum Asset {
    {{templateItems}}
}
"""

let ImageAssetsTemplate = """

import UIKit

enum ImageAssets: String, CaseIterable {

    {{AssetItems}}

    var nameEnum: String {
        return Mirror(reflecting: self).children.first?.label ?? String(describing: self)
    }

    static func imageFromString(_ name: String) -> UIImage? {
        return ImageAssets.allCases.first(where: { $0.nameEnum.elementsEqual(name) })?.toImage()
    }

    static func dataFromString(_ name: String) -> Data? {
        return ImageAssets.allCases.first(where: { $0.nameEnum.elementsEqual(name) })?.toData()
    }

    private func toData() -> Data? {
        Data(base64Encoded: self.rawValue, options: .ignoreUnknownCharacters)
    }

    private func toImage() -> UIImage? {
        guard let data = self.toData() else {
            return nil
        }
        return UIImage(data: data)
    }
}
"""

