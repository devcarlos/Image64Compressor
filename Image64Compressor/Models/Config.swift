//
//  FileProcessor.swift
//  Image64Compresor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.
//

import Foundation

struct Config: Decodable {
    var projectName: String?
    var assetsPath: String?

    init() {
        assetsPath = ""
        projectName = ""
    }

    init(_ commands: [Command]) {
        commands.forEach { option, value in
            switch option {
            case .projectName:
                self.projectName = value
            case .rootPath:
                self.assetsPath = value
            default:
                break
            }
        }
    }

    var itemsTemplatePath: String? {
        return assetsPath?.appending("/\(FileType.itemsTemplate.rawValue)")
    }

    var assetsTemplatePath: String? {
        return assetsPath?.appending("/\(FileType.assetsTemplate.rawValue)")
    }
}
