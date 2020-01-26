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

let compresor = ImageCompressor()
if CommandLine.argc < 2 {
  compresor.interactiveMode()
} else {
  compresor.staticMode()
}


