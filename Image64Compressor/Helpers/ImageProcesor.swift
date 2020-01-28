//
//  FileProcessor.swift
//  Image64Compressor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.

import AppKit

enum ImageProcesor {

    static func processImages(_ files: [URL]) -> [ImageAsset] {
        var assetsKeys: [String: Int] = [:]
        var assets: [ImageAsset] = []
        files.forEach { url in
            if let base64String = NSImage(contentsOf: url)?.png?.base64EncodedString() {
                let name = url.deletingPathExtension().lastPathComponent
                var key = name
                    .replacingOccurrences(of: "_", with: " ")
                    .replacingOccurrences(of: "-", with: " ")
                    .lowerCamelCased
                key.removeAllNonAlphanumericsCharacters()
                if key.first?.isNumber == true {
                    key.insert("_", at: key.startIndex)
                }
                if let value = assetsKeys[key] {
                    assetsKeys[key] = value + 1
                    key.append("\(value + 1)")
                } else {
                    assetsKeys[key] = 1
                }
                let imageAsset = ImageAsset(name: name, key: key, base64: base64String)
                assets.append(imageAsset)
            }
        }
        return assets
    }

}
