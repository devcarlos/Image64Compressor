//
//  NSImage+extensions.swift
//  Image64Compressor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.
//

import Foundation
import AppKit

extension NSImage {
    var png: Data? { tiffRepresentation?.bitmap?.png }
}
