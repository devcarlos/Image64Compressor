//
//  FileProcessor.swift
//  ImageConverterConsole
//


import AppKit

enum ImageProcesor {

    static func processImages(_ files: [URL]) -> [ImageAsset] {
        var assets: [ImageAsset] = []
        files.forEach { url in
            if let base64String = NSImage(contentsOf: url)?.png?.base64EncodedString() {
                let name = url.deletingPathExtension().lastPathComponent
                let key = name
                    .replacingOccurrences(of: "_", with: " ")
                    .replacingOccurrences(of: "-", with: " ")
                    .replacingOccurrences(of: "@", with: "")
                    .trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
                    .lowerCamelCased
                let imageAsset = ImageAsset(name: name, key: key, base64: base64String)
                assets.append(imageAsset)
            }
        }
        return assets
    }

}
