//
//  ImageCompressor.swift
//  Image64Compressor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.
//

/// ************************
/// Image Base 64 Compressor
/// ************************

import Foundation
import AppKit

class ImageCompressor {

    let parser = ArgumentsParser()
    var config = Config()

    func staticMode(_ arguments: [String]) {
        parser.parseCommands(arguments)
        config = parser.getConfig()
        self.startCompressor()
    }

    func interactiveMode() {
        parser.interactiveMode { config in
            self.config = config
            self.startCompressor()
        }
    }

    private func startCompressor() {
        if let rootPath = config.rootPath {
            processAllImages(at: rootPath)
        } else {
            ConsoleIO.writeMessage("Invalid root path", to: .error)
            ConsoleIO.quit()
        }
    }

    private func processAllImages(at path: String) {
        let imagesUrl = FileProcessor.findAllFiles(at: path)

        guard !imagesUrl.isEmpty else {
            ConsoleIO.writeMessage("Unable to find image files on \(path)", to: .error)
            return
        }

        let assets = ImageProcesor.processImages(imagesUrl)

        guard !assets.isEmpty else {
            ConsoleIO.writeMessage("Unable to process images.", to: .error)
            return
        }

        //create template Swift files
        let template = TemplateProcessor(config: config)
        if template.createTemplates(assets) {
            ConsoleIO.writeMessage("Created Template files: \(FileType.assets.rawValue) and \(FileType.items.rawValue) successfully.")
        } else {
            ConsoleIO.writeMessage("Unable to create template images.", to: .error)
        }
    }
}
