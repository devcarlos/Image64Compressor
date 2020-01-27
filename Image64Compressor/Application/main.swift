//
//  main.swift
//  Image64Compresor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.
//

/// ************************
/// Image Base 64 Compressor
/// ************************

import Foundation

let compressor = ImageCompressor()

if CommandLine.argc < 2 {
    compressor.interactiveMode()
} else {
    compressor.staticMode(CommandLine.arguments)
}
