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
        writeMessage("*******************************************************")
        writeMessage("\(executableName) -config filepath to json or plist file (e.g. /Users/user/Desktop/config.json)")
        writeMessage("Configuration file example")
        writeMessage(
            """
                {
                    "projectName": "Demo",
                    "rootPath": "/Users/user/Desktop/"
                }
            """
        )
        writeMessage("*******************************************************")
        writeMessage("\(executableName) --projectName this optional, it use in the templates")
        writeMessage("*******************************************************")
        writeMessage("\(executableName) --assetsPath the location of the assets (e.g. /Users/user/Desktop/Assets.xcassets)")
        writeMessage("*******************************************************")
        writeMessage("\(executableName) --help to show usage information")
        writeMessage("*******************************************************")
        writeMessage("\(executableName) --quit to end program execution")
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

