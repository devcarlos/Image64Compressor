//
//  ConsoleIO.swift
//  Image64Compressor
//
//  Copyright © 2020 DevCarlos & iAle. All rights reserved.
//

/// ************************
/// Image Base 64 Compressor
/// ************************

import Foundation

enum OutputType {
    case error
    case standard
}

enum ConsoleIO {

    static func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            // 1
            print("\u{001B}[;m\(message)")
        case .error:
            // 2
            fputs("\u{001B}[0;31m\(message)\n", stderr)
        }
    }

    static func printUsage() {

        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent

        writeMessage("usage:")
        writeMessage("\(executableName) -all filepath (e.g. /Users/user/Desktop/Assets)")
        writeMessage("or")
        writeMessage("\(executableName) -h to show usage information")
        writeMessage("Type \(executableName) without an option to enter interactive mode.")
    }

    static func getInput() -> String {
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        if let strData = String(data: inputData, encoding: String.Encoding.utf8) {
            return strData.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        } else {
            writeMessage("Invalid input", to: .error)
            quit()
            return ""
        }
    }

    static func quit() {
        exit(0)
    }
}

