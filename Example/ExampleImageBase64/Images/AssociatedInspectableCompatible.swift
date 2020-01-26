//
//  AssociatedInspectableCompatible.swift
//  Example
//
//  Copyright © 2019 DevCarlos & iAle. All rights reserved.
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

// MARK: - AssociatedInspectableCompatible

public extension UIImageView {
    @IBInspectable
    override var assetKey: String? {
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

// MARK: - All IBInspectable for UIView

public extension AssociatedInspectableExtension where InspectableBase: UIView {
    var name: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).AssociatedKeys.assetKey
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).AssociatedKeys.assetKey,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

// MARK: - UIView for AssociatedInspectableCompatible

public extension UIView {
    enum AssociatedKeys {
        static var assetKey = "\(type(of: self)).AssetKey"
    }

    @IBInspectable
    var assetKey: String? {
        get { associatedValue.name }
        set {
            if let value = newValue,
                !value.trimmedString.isEmpty,
                let image = ImageAssets.imageFromString(value) {
                setBackgroundLayer(image: image)
            }
            associatedValue.name = newValue
        }
    }

    private func setBackgroundLayer(image: UIImage) {
        var imageLayer: CALayer? = nil
        let mask = CAShapeLayer()
        let path = UIBezierPath(rect: bounds)
        mask.fillColor = UIColor.black.cgColor
        mask.path = path.cgPath
        mask.frame = self.bounds
        layer.addSublayer(mask)
        imageLayer = CAShapeLayer()
        imageLayer?.frame = self.bounds
        imageLayer?.mask = mask
        imageLayer?.contentsGravity = CALayerContentsGravity.resizeAspectFill
        imageLayer?.contents = image.cgImage
        layer.addSublayer(imageLayer!)
    }
}


// MARK: - All IBInspectable for UIButton

public extension AssociatedInspectableExtension where InspectableBase: UIButton {
    var defaultName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).AssociatedKeys.normalAssetKey
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).AssociatedKeys.normalAssetKey,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    var highlightedName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).AssociatedKeys.highlightedAssetKey
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).AssociatedKeys.highlightedAssetKey,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    var selectedName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).AssociatedKeys.selectedtName
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).AssociatedKeys.selectedtName,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    var disabledName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).AssociatedKeys.disabledAssetKey
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).AssociatedKeys.disabledAssetKey,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

// MARK: - UIButton

public extension UIButton {

    enum AssociatedKeys {
        static var normalAssetKey = "\(type(of: self)).normalAssetKey"
        static var highlightedAssetKey = "\(type(of: self)).highlightedAssetKey"
        static var selectedtName = "\(type(of: self)).selectedtName"
        static var disabledAssetKey = "\(type(of: self)).disabledAssetKey"
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

    @IBInspectable var selectedtName: String? {
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
            &type(of: base).AssociatedKeys.imageName
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).AssociatedKeys.imageName,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

// MARK: - AssociatedInspectableCompatible

public extension UIBarButtonItem {
    enum AssociatedKeys {
        static var imageName = "\(type(of: self)).AssetKey"
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
            &type(of: base).AssociatedKeys._imageName
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).AssociatedKeys._imageName,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    var selectedImageName: String? {
        get { objc_getAssociatedObject(
            base,
            &type(of: base).AssociatedKeys._selectedImageName
            ) as? String
        }
        set { objc_setAssociatedObject(
            base,
            &type(of: base).AssociatedKeys._selectedImageName,
            newValue,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

// MARK: - AssociatedInspectableCompatible

public extension UITabBarItem {
    enum AssociatedKeys {
        static var _imageName = "\(type(of: self)).AssetKey"
        static var _selectedImageName = "\(type(of: self)).AssetKey"
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
