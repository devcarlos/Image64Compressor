//
//  ImageAssetsTemplate.swift
//  Image64Compressor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.
//

let imageAssetsTemplateString = """
//
//  {{ProjectName}}Assets.swift
//  {{ProjectName}}
//

import UIKit

enum {{ProjectName}}ImageAssets: CaseIterable {

    static let assets: [String: String] = [
        {{AssetValues}}
    ]

    {{AssetItems}}

    var nameEnum: String {
        Mirror(reflecting: self).children.first?.label ?? String(describing: self)
    }

    static func imageFromString(_ name: String) -> UIImage? {
        {{ProjectName}}ImageAssets.allCases.first(where: { $0.nameEnum.elementsEqual(name) })?.toImage()
    }

    static func dataFromString(_ name: String) -> Data? {
        {{ProjectName}}ImageAssets.allCases.first(where: { $0.nameEnum.elementsEqual(name) })?.toData()
    }

    private func toData() -> Data? {
        Data(base64Encoded: {{ProjectName}}ImageAssets.assets[nameEnum]!, options: .ignoreUnknownCharacters)
    }

    private func toImage() -> UIImage? {
        guard let data = self.toData() else {
            return nil
        }
        return UIImage(data: data)
    }
}
"""
