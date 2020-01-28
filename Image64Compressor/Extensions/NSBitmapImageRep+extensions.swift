//
//  NSBitmapImageRep+extensions.swift
//  Image64Compressor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.
//

import AppKit

extension NSBitmapImageRep {
    var png: Data? { representation(using: .png, properties: [:]) }
}
