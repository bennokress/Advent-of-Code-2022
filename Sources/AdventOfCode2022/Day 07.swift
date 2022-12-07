//
// 💡 Advent of Code 2022 - Day 07
// 🎅🏽 Author: Benno Kress
//

import Foundation

public class Solver07 {
    
    var rootFolder = Folder(name: "/")
    var allFolders: [Folder] = []
    
    var spaceToFreeUp: Int {
        let totalSpace = 70000000
        let neededSpace = 30000000
        let usedSpace = rootFolder.size
        return max(0, neededSpace - (totalSpace - usedSpace))
    }
    
    init() { }
    
    func parseStuff(from input: String) {
        let inputEntries = input.components(separatedBy: .newlines).dropFirst()
        let actions = inputEntries.compactMap { TerminalLine($0).output }
        var currentFolder = rootFolder
        var parentFolders: [Folder] = []
        for action in actions {
            act(on: action, in: &currentFolder, with: &parentFolders)
        }
        while !parentFolders.isEmpty {
            act(on: .stepOut, in: &currentFolder, with: &parentFolders)
        }
        rootFolder = currentFolder
        print(rootFolder.size)
    }
    
    /// The combined size of all folders on disk that have a maximum size of 100000
    var answer1: Int {
        allFolders
            .filter { $0.size <= 100000 }
            .map(\.size)
            .reduce(0, +)
    }
    
    /// The size of the smallest folder needed to clear enough space
    var answer2: Int {
        allFolders
            .filter { $0.size >= spaceToFreeUp }
            .sorted { $0.size < $1.size }
            .first!
            .size
    }
    
    private func act(on command: TerminalLine.Output, in currentFolder: inout Folder, with parentFolders: inout [Folder]) {
        switch command {
        case let .stepIntoFolder(folderName): stepIntoFolder(named: folderName, from: &currentFolder, with: &parentFolders)
        case .stepOut: stepOutOfCurrentFolder(using: &parentFolders, updating: &currentFolder)
        case .showContent: return
        case let .createFolder(folder): create(folder, inside: &currentFolder)
        case let .createFile(file): create(file, inside: &currentFolder)
        }
    }
    
    private func stepIntoFolder(named folderName: String, from currentFolder: inout Folder, with parentFolders: inout [Folder]) {
        guard let nestedFolder = currentFolder.containedFolders.first(where: { $0.name == folderName }) else { fatalError("Folder named '\(folderName)' does not exist in current folder '\(currentFolder.name)'!") }
        parentFolders.append(currentFolder)
        currentFolder = nestedFolder
    }
    
    private func stepOutOfCurrentFolder(using parentFolders: inout [Folder], updating currentFolder: inout Folder) {
        guard !parentFolders.isEmpty else { fatalError("Cannot step out of folder without any parent folders") }
        allFolders.append(currentFolder)
        let containedFolderSize = currentFolder.size
        currentFolder = parentFolders.removeLast()
        currentFolder.containedFoldersSize += containedFolderSize
    }
    
    private func create(_ folder: Folder, inside currentFolder: inout Folder) {
        currentFolder.containedFolders.append(folder)
    }
    
    private func create(_ file: File, inside currentFolder: inout Folder) {
        currentFolder.containedFiles.append(file)
    }
    
}

extension Solver07: Solver {
    
    public func solve(using input: String) { parseStuff(from: input) }
    
    public var solutionPart1: String { String(answer1) }
    
    public var solutionPart2: String { String(answer2) }
    
}

extension Solver07: CustomStringConvertible {
    
    public var description: String {
        """
        \(descriptionTitle)
        
        The answer to part 1 is \(solutionPart1).
        The answer to part 2 is \(solutionPart2).
        """
    }
    
    private var descriptionTitle: String { "✼*✻*✼*✻* Day 07 *✻*✼*✻*✼" }
    
}

// MARK: - Supporting Types

struct TerminalLine {
    
    let input: Input?
    
    var output: Output? {
        guard let input else { return nil }
        switch input {
        case let .cd(folderName):
            if folderName == ".." {
                return .stepOut
            } else {
                return .stepIntoFolder(named: folderName)
            }
            
        case .ls:
            return .showContent
            
        case let .recognizeFolder(name):
            let folder = Folder(name: name)
            return.createFolder(folder: folder)
            
        case let .recognizeFile(size, name):
            let file = File(size: size, name: name)
            return.createFile(file: file)
        }
    }
    
    init(_ line: String) {
        self.input = Input(from: line)
    }
    
    enum Input {
        
        case cd(folderName: String)
        case ls
        case recognizeFolder(name: String)
        case recognizeFile(size: Int, name: String)
        
        init?(from terminalLine: String) {
            if terminalLine.hasPrefix("$ ") {
                self.init(command: String(terminalLine.dropFirst(2)))
            } else if terminalLine.hasPrefix("dir") {
                self = .recognizeFolder(name: String(terminalLine.dropFirst(4)))
            } else {
                guard let fileSizeString = terminalLine.components(separatedBy: .whitespaces).first, let fileSize = Int(fileSizeString), let fileName = terminalLine.components(separatedBy: .whitespaces).last else { return nil }
                self = .recognizeFile(size: fileSize, name: fileName)                
            }
        }
        
        private init(command: String) {
            if command.hasPrefix("cd ") {
                self = .cd(folderName: String(command.dropFirst(3)))
            } else {
                self = .ls
            }
        }
        
    }
    
    enum Output {
        
        case stepIntoFolder(named: String)
        case stepOut
        case showContent
        case createFolder(folder: Folder)
        case createFile(file: File)
        
    }
    
}

struct Folder {
    
    let name: String
    
    var containedFolders: [Folder] = []
    var containedFiles: [File] = []
    
    var containedFoldersSize = 0
    
    var size: Int {
        containedFoldersSize + containedFilesSize
    }
    
    var containedFilesSize: Int {
        containedFiles.map(\.size).reduce(0, +)
    }
    
}

struct File {
    
    let size: Int
    let name: String
    
}
