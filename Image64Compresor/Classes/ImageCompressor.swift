//
//  ImageCompressor.swift
//  Image64Compresor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.
//

/// ************************
/// Image Base 64 Compressor
/// ************************

import Foundation
import AppKit

enum OptionType: String {
    case all = "all"
    case help = "h"
    case quit = "q"
    case unknown

    init(value: String) {
        switch value {
        case "all": self = .all
        case "h": self = .help
        case "q": self = .quit
        default: self = .unknown
        }
    }
}

enum FileType: String {
    case asset = "Asset.swift"
    case items = "Items.swift"
}

class ImageCompressor {

    let consoleIO = ConsoleIO()

    func getOption(_ option: String) -> (option:OptionType, value: String) {
        return (OptionType(value: option), option)
    }

    func staticMode() {
        let argCount = CommandLine.argc
        let argument = CommandLine.arguments[1]
        let (option, value) = getOption(argument.trimmingCharacters(in: CharacterSet.init(charactersIn: "-")))

        switch option {
        case .all:
            if argCount != 3 {
                if argCount > 3 {
                    consoleIO.writeMessage("Too many arguments for option \(option.rawValue)", to: .error)
                } else {
                    consoleIO.writeMessage("Too few arguments for option \(option.rawValue)", to: .error)
                }
                consoleIO.printUsage()
            } else {
                let filepath = CommandLine.arguments[2]
                processAllImages(filepath: filepath)

            }
        case .help:
            consoleIO.printUsage()

        case .unknown, .quit:
            consoleIO.writeMessage("Unknown option \(value)")
            consoleIO.printUsage()
        }
    }

    func interactiveMode() {
        //1
        consoleIO.writeMessage("Welcome to ImageCompressor. This program generates an Asset File with Base 64 Encoded Images from Templates.")
        //2
        var shouldQuit = false
        while !shouldQuit {
            consoleIO.writeMessage("Type 'all' to compress image assets to base 64 type 'q' to quit.")
            let (option, value) = getOption(consoleIO.getInput())

            switch option {
            case .all:
                consoleIO.writeMessage("Type the filepath:")
                let filepath = consoleIO.getInput()
                processAllImages(filepath: filepath)
            case .quit:
                shouldQuit = true
            default:
                consoleIO.writeMessage("Unknown option \(value)", to: .error)
            }
        }
    }

    private func processAllImages(filepath: String) {
        let imagesUrl = findAllFiles("\(filepath)/Assets.xcassets/")
        guard !imagesUrl.isEmpty else {
            consoleIO.writeMessage("Unable to find image files on \(filepath)", to: .error)
            return
        }

        let assets = processImages(imagesUrl)

        guard !assets.isEmpty else {
            consoleIO.writeMessage("Unable to process images.", to: .error)
            return
        }

        //create template Swift files
        if createTemplate(rootPath: filepath, assets) {
            consoleIO.writeMessage("Created Template files: \(FileType.asset.rawValue) and \(FileType.items.rawValue) successfully.")
        } else {
            consoleIO.writeMessage("Unable to create template images.", to: .error)
        }
    }

    // MARK : - Private Helpers

    private func findAllFiles(_ path: String) -> [URL] {
        var imagesUrl: [URL] = []
        let url = URL(fileURLWithPath: path)
        let enumerator = FileManager.default.enumerator(
            at: url,
            includingPropertiesForKeys: [.isRegularFileKey],
            options: [.skipsHiddenFiles, .skipsPackageDescendants]
        ) { url, error -> Bool in
            print(url.absoluteString)
            debugPrint(error)
            return false
        }
        while let item = enumerator?.nextObject() as? URL {
            let pathExtension = item.pathExtension
            if case let itemExtension = pathExtension.pathExtension, itemExtension != .none {
                imagesUrl.append(item)
            }
        }
        return imagesUrl
    }

    func processImages(_ files: [URL]) -> [ImageAsset] {
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

    func createTemplate(rootPath: String, _ assets: [ImageAsset]) -> Bool {
        let templateItems = assets.map { PrintableImageAsset.templateItem($0) }.joined(separator: "")
        let assetItems = assets.map { PrintableImageAsset.assetItem($0) }.joined(separator: "")
        let assetTemplate = AssetTemplate.replacingOccurrences(of: "{{templateItems}}", with: templateItems)
        let imageAssetsTemplate = ImageAssetsTemplate.replacingOccurrences(of: "{{AssetItems}}", with: assetItems)

        let isAssetTemplateCreated = FileManager.default.createFile(
            atPath: "\(rootPath)/\(FileType.asset.rawValue)",
            contents: assetTemplate.data(using: .utf8),
            attributes: nil
        )
        let isImageAssetsTemplateCreated = FileManager.default.createFile(
            atPath: "\(rootPath)/\(FileType.items.rawValue)",
            contents: imageAssetsTemplate.data(using: .utf8),
            attributes: nil
        )
        print("Asset created: \(isAssetTemplateCreated)")
        print("ImageAssets created: \(isImageAssetsTemplateCreated)")

        return isAssetTemplateCreated && isImageAssetsTemplateCreated
    }
}
