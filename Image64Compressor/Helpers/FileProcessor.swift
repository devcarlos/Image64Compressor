//
//  FileProcessor.swift
//  Image64Compressor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.

import Foundation

enum FileProcessor {
 
    static func loadFile(at path: String) -> Data? {
        if !FileManager.default.fileExists(atPath: path) {
            return nil
        }
        return FileManager.default.contents(atPath: path)
    }

    static func loadConfig(at path: String) -> Config {
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            if url.pathExtension != "plist" {
                let decoder = JSONDecoder()
                return try decoder.decode(Config.self, from: data)
            } else {
                let decoder = PropertyListDecoder()
                return try decoder.decode(Config.self, from: data)
            }
        } catch {
            debugPrint(error.localizedDescription)
            return Config()
        }
    }

    static func findAllFiles(at path: String) -> [URL] {
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

    static func createFile(atPath: String, contents: Data?) -> Bool {
        return FileManager.default.createFile(
            atPath: atPath,
            contents: contents,
            attributes: nil
        )
    }

}
