//
//  FileProcessor.swift
//  Image64Compresor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.
//

import Foundation

struct Config: Decodable {
    var projectName: String?
    var rootPath: String?

    init() {
        rootPath = ""
        projectName = ""
    }

    init(_ commands: [Command]) {
        commands.forEach { option, value in
            switch option {
            case .projectName:
                self.projectName = value
            case .rootPath:
                self.rootPath = value
            default:
                break
            }
        }
    }

    var itemsTemplatePath: String? {
        return rootPath?.appending("/\(FileType.itemsTemplate.rawValue)")
    }

    var assetsTemplatePath: String? {
        return rootPath?.appending("/\(FileType.assetsTemplate.rawValue)")
    }
}
