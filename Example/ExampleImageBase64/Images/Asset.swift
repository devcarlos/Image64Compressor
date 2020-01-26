
import UIKit

public typealias AssetImageTypeAlias = UIImage
public typealias AssetDataTypeAlias = Data

public struct ImageAsset {
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
    public static let example = ImageAsset(name: "example", key: "example")
}
