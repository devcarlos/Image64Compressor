//
//  FileProcessor.swift
//  ImageConverterConsole
//

import Foundation

enum FileType: String {
    case assets = "Assets.swift"
    case items = "AssetsItems.swift"
    case assetsTemplate = "AssetsTemplate.tmp"
    case itemsTemplate = "ItemsTemplate.tmp"
    case associatedInspectableCompatible = "AssociatedInspectableCompatible.swift"
    case associatedInspectableCompatibleTemplate = "AssociatedInspectableCompatible.tmp"
}

class TemplateProcessor {

    let projectTemplateContents: String
    let imageAssetTemplateContents: String
    let associatedInspectableCompatibleTemplateContents: String
    let config: Config

    init(config: Config) {
        self.config = config

        let projectTemplatePath = config.itemsTemplatePath ?? ""
        let projectData = FileProcessor.loadFile(at: projectTemplatePath)
        if let validData = projectData, let stringData = String(data: validData, encoding: .utf8) {
            projectTemplateContents = stringData
        } else {
            projectTemplateContents = projectAssetTemplateString
        }

        let imageAssetTemplatePath = config.assetsTemplatePath ?? ""
        let assetsData = FileProcessor.loadFile(at: imageAssetTemplatePath)
        if let validData = assetsData, let stringData = String(data: validData, encoding: .utf8) {
            imageAssetTemplateContents = stringData
        }else {
            imageAssetTemplateContents = imageAssetsTemplateString
        }

        // Just for now
        associatedInspectableCompatibleTemplateContents = associatedInspectableCompatibleTemplate
    }

    func createTemplates(_ assets: [ImageAsset]) -> Bool {

        guard let assetsPath = config.assetsPath, let projectName = config.projectName else {
            return false
        }

        let destinationPath = assetsPath.appending("/..")

        let templateItems = assets.map { PrintableImageAsset.templateItem($0) }.joined(separator: "")
        let assetItems = assets.map { PrintableImageAsset.assetItem($0) }.joined(separator: "")

        var projectTemplate = projectTemplateContents.replacingOccurrences(
            of: "{{templateItems}}", with: templateItems
        )
        replaceProjectName(projectName, template: &projectTemplate)

        var imageAssetsTemplate = imageAssetTemplateContents.replacingOccurrences(
            of: "{{AssetItems}}", with: assetItems
        )
        replaceProjectName(projectName, template: &imageAssetsTemplate)

        ConsoleIO.writeMessage("Creating file \(destinationPath)/\(projectName)\(FileType.assets.rawValue)")
        let projectTemplateCreated = FileProcessor.createFile(
            atPath: "\(destinationPath)/\(projectName)\(FileType.assets.rawValue)",
            contents: projectTemplate.data(using: .utf8)
        )

        ConsoleIO.writeMessage("Creating file \(destinationPath)/\(projectName)\(FileType.items.rawValue)")
        let imageAssetsTemplateCreated = FileProcessor.createFile(
            atPath: "\(destinationPath)/\(projectName)\(FileType.items.rawValue)",
            contents: imageAssetsTemplate.data(using: .utf8)
        )

        ConsoleIO.writeMessage("Creating file \(destinationPath)/\(projectName)\(FileType.associatedInspectableCompatible.rawValue)")
        var template = associatedInspectableCompatibleTemplateContents
        replaceProjectName(projectName, template: &template)

        let associatedCompatibleTemplateCreated = FileProcessor.createFile(
            atPath: "\(destinationPath)/\(projectName)\(FileType.associatedInspectableCompatible.rawValue)",
            contents: template.data(using: .utf8)
        )

        ConsoleIO.writeMessage("Location: \(destinationPath)")
        ConsoleIO.writeMessage("Project assets created: \(projectTemplateCreated)")
        ConsoleIO.writeMessage("Image assets created: \(imageAssetsTemplateCreated)")
        ConsoleIO.writeMessage("Associated Compatible Template created: \(associatedCompatibleTemplateCreated)")

        return projectTemplateCreated && imageAssetsTemplateCreated && associatedCompatibleTemplateCreated
    }

    func replaceProjectName(_ projectName: String, template: inout String) {
        template = template.replacingOccurrences(of: "{{ProjectName}}", with: projectName)
    }

}
