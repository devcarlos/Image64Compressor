//
//  AssociatedInspectableCompatibleTemplate.swift
//  Image64Compressor
//

import Foundation

let associatedInspectableCompatibleTemplate = """
//
//  {{ProjectName}}AssociatedInspectableCompatible.swift
//  {{ProjectName}}
//

import Foundation
import UIKit

extension String {
    public var trimmedString: String {
        trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

// MARK: - AssociatedType

public protocol AssociatedInspectableCompatible {
    associatedtype CompatibleType

    var associatedValue: AssociatedInspectableExtension<CompatibleType> { get set }
}

public extension AssociatedInspectableCompatible {
    var associatedValue: AssociatedInspectableExtension<Self> {
        get { AssociatedInspectableExtension(self) }
        set { }
    }
}

public class AssociatedInspectableExtension<InspectableBase> {
    public let base: InspectableBase

    init(_ base: InspectableBase) {
        self.base = base
    }
}

extension UIView: AssociatedInspectableCompatible { }
extension UIBarItem: AssociatedInspectableCompatible { }

// MARK: - All IBInspectable for UIImageView

public extension AssociatedInspectableExtension where InspectableBase: UIImageView {
    var name: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.assetKey
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.assetKey,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

// MARK: - AssociatedInspectableCompatible

public extension UIImageView {
    enum {{ProjectName}}AssociatedKeys {
        static var assetKey = "\\(type(of: self)).AssetKey"
    }

    @IBInspectable var assetKey: String? {
        get { associatedValue.name }
        set {
            if let value = newValue,
                !value.trimmedString.isEmpty,
                let image = ImageAssets.imageFromString(value) {
                self.image = image
            }
            associatedValue.name = newValue
        }
    }
}

// MARK: - All IBInspectable for UIButton

public extension AssociatedInspectableExtension where InspectableBase: UIButton {
    var defaultName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.normalAssetKey
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.normalAssetKey,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    var highlightedName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.highlightedAssetKey
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.highlightedAssetKey,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    var selectedName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.selectedName
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.selectedName,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    var disabledName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.disabledAssetKey
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.disabledAssetKey,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

// MARK: - UIButton

public extension UIButton {

    enum {{ProjectName}}AssociatedKeys {
        static var normalAssetKey = "\\(type(of: self)).normalAssetKey"
        static var highlightedAssetKey = "\\(type(of: self)).highlightedAssetKey"
        static var selectedName = "\\(type(of: self)).selectedName"
        static var disabledAssetKey = "\\(type(of: self)).disabledAssetKey"
    }

    @IBInspectable var normalAssetKey: String? {
        get { associatedValue.defaultName }
        set {
            if let value = newValue,
                !value.trimmedString.isEmpty,
                let image = ImageAssets.imageFromString(value) {
                self.setImage(image, for: .normal)
            }
            associatedValue.defaultName = newValue
        }
    }

    @IBInspectable var highlightedAssetKey: String? {
        get { associatedValue.highlightedName }
        set {
            if let value = newValue,
                !value.trimmedString.isEmpty,
                let image = ImageAssets.imageFromString(value) {
                self.setImage(image, for: .highlighted)
            }
            associatedValue.highlightedName = newValue
        }
    }

    @IBInspectable var selectedName: String? {
        get { associatedValue.selectedName }
        set {
            if let value = newValue,
                !value.trimmedString.isEmpty,
                let image = ImageAssets.imageFromString(value) {
                self.setImage(image, for: .selected)
            }
            associatedValue.selectedName = newValue
        }
    }

    @IBInspectable var disabledAssetKey: String? {
        get { associatedValue.disabledName }
        set {
            if let value = newValue,
                !value.trimmedString.isEmpty,
                let image = ImageAssets.imageFromString(value) {
                self.setImage(image, for: .disabled)
            }
            associatedValue.disabledName = newValue
        }
    }
}

// MARK: - All IBInspectable for UIBarButtonItem

public extension AssociatedInspectableExtension where InspectableBase: UIBarButtonItem {
    var imageName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.imageName
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.imageName,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

// MARK: - AssociatedInspectableCompatible

public extension UIBarButtonItem {
    enum {{ProjectName}}AssociatedKeys {
        static var imageName = "\\(type(of: self)).AssetKey"
    }

    @IBInspectable var imageName: String? {
        get { associatedValue.imageName }
        set {
            if let value = newValue,
                !value.trimmedString.isEmpty,
                let image = ImageAssets.imageFromString(value) {
                self.image = image
            }
            associatedValue.imageName = newValue
        }
    }
}


// MARK: - All IBInspectable for UITabBarItem

public extension AssociatedInspectableExtension where InspectableBase: UITabBarItem {
    var imageName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.imageName
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.imageName,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    var selectedImageName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.selectedImageName
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).{{ProjectName}}AssociatedKeys.selectedImageName,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

// MARK: - AssociatedInspectableCompatible

public extension UITabBarItem {
    enum {{ProjectName}}AssociatedKeys {
        static var imageName = "\\(type(of: self)).AssetKey"
        static var selectedImageName = "\\(type(of: self)).AssetKey"
    }

    @IBInspectable var selectedImageName: String? {
        get { associatedValue.selectedImageName }
        set {
            if let value = newValue,
                !value.trimmedString.isEmpty,
                let image = ImageAssets.imageFromString(value) {
                self.selectedImage = image
            }
            associatedValue.imageName = newValue
        }
    }

    @IBInspectable var imageName: String? {
        get { associatedValue.imageName }
        set {
            if let value = newValue,
                !value.trimmedString.isEmpty,
                let image = ImageAssets.imageFromString(value) {
                self.image = image
            }
            associatedValue.imageName = newValue
        }
    }
}

"""
