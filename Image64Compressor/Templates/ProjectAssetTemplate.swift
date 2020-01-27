//
//  ProjectAssetTemplate.swift
//  Image64Compressor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.
//

let projectAssetTemplateString = """
//
//  {{ProjectName}}ImageAssets.swift
//  {{ProjectName}}
//

import UIKit

public typealias AssetImageTypeAlias = UIImage
public typealias AssetDataTypeAlias = Data

public struct {{ProjectName}}ImageAsset {
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
