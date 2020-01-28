//
//  Data+extensions.swift
//  Image64Compressor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.
//

import AppKit

extension Data {
    var bitmap: NSBitmapImageRep? { NSBitmapImageRep(data: self) }
}
