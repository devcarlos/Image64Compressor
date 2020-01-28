//
//  FileProcessor.swift
//  ImageConverterConsole
//

import Foundation

typealias Command = (CommandType, String)

enum CommandType: String {
    case config
    case help
    case projectName
    case rootPath
    case unknown
    case quit

    init(value: String) {
        let type = value.replacingOccurrences(of: "--", with: "")
        self = CommandType(rawValue: type) ?? .unknown
    }
}

class ArgumentsParser {

    var commands: [Command] = []

    init(_ args: [String] = []) {
        parseCommands(args)
    }

    private func getConfigPath() -> String {
        let configCommand = commands.first {
            $0.0 == .config
        }
        return configCommand != nil ? configCommand!.1 : ""
    }

    func getOption(_ option: String) -> Command {
        return (CommandType(value: option), option)
    }

    func getConfig() -> Config {
        let configPath = getConfigPath()
        if configPath.isEmpty {
            return Config(commands)
        } else {
            return FileProcessor.loadConfig(at: configPath)
        }
    }

    func parseCommands(_ args: [String]) {
        var tempArgs = args
        while tempArgs.first != nil {
            let arg = tempArgs.removeFirst()
            let value = !tempArgs.isEmpty ? tempArgs.removeFirst() : ""
            let command = CommandType(value: arg)
            switch command {
            case .config, .projectName, .rootPath:
                commands.append(Command(command, value))
            case .help:
                ConsoleIO.printUsage()
            default:
                break
            }
        }
    }

    func interactiveMode(handler: @escaping (Config) -> Void) {

        ConsoleIO.writeMessage("Welcome to ImageCompressor. This program generates an Asset File with Base 64 Encoded Images from Templates.")
        ConsoleIO.printUsage()
        commandCascade([.config, .projectName, .rootPath]) {
            handler(self.getConfig())
        }
    }

    func commandCascade(_ options: [CommandType], handler: @escaping () -> Void) {
        var inputOptions = options

        while !inputOptions.isEmpty {

            let option = inputOptions.removeFirst()

            switch option {

            case .rootPath:
                ConsoleIO.writeMessage("Type the assets path (*):")
                let value = ConsoleIO.getInput()
                commands.append(Command(.rootPath, value))

            case .projectName:
                ConsoleIO.writeMessage("Type the project name (optional):")
                let value = ConsoleIO.getInput()
                commands.append(Command(.projectName, value))

            case .config:
                ConsoleIO.writeMessage("Type the config file path (optional):")
                let value = ConsoleIO.getInput()
                if !value.isEmpty {
                    commands.append(Command(.config, value))
                    inputOptions.removeAll()
                }

            case .help:
                ConsoleIO.printUsage()

            case .quit:
                inputOptions.removeAll()
                handler()

            default:
                ConsoleIO.writeMessage("Unknown option", to: .error)
            }

        }

        handler()
    }

}

