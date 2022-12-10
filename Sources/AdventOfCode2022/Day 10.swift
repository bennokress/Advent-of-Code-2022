//
// 💡 Advent of Code 2022 - Day 10
// 🎅🏽 Author: Benno Kress
//

import Foundation

public class Solver10 {
    
    private var signalStrengthProgression = [1]
    
    private func index(during cycle: Int) -> Int { cycle - 1 }
    private func index(after cycle: Int) -> Int { cycle }
    
    private func signalStrength(during cycle: Int) -> Int { cycle * signalStrengthProgression[index(during: cycle)] }
    private let interestingCycles = [20, 60, 100, 140, 180, 220]
    
    private func register(during cycle: Int) -> Int { signalStrengthProgression[index(during: cycle)] }
    private func sprite(during cycle: Int) -> ClosedRange<Int> { (register(during: cycle) - 1)...(register(during: cycle) + 1) }
    private func pixelPosition(during cycle: Int) -> Int { (cycle - 1) % 40 }
    private func pixel(for cycle: Int) -> String {
        let sprite = sprite(during: cycle)
        let pixelPosition = pixelPosition(during: cycle)
        let isPixelLit = sprite.contains(pixelPosition)
        return isPixelLit ? "█" : " "
    }
    
    init() { }
    
    func parseStuff(from input: String) {
        input
            .components(separatedBy: .newlines)
            .map { Signal(from: $0) }
            .forEach { $0.process(on: &signalStrengthProgression) }
    }
    
    /// The sum of the signal strengths of the interesting cycles
    var answer1: Int {
        interestingCycles
            .map { signalStrength(during: $0) }
            .reduce(0, +)
    }
    
    /// The Pixel Output on the CRT
    var answer2: String {
        let cycles = 1...signalStrengthProgression.count
        let pixels = cycles
            .flatMap { pixel(for: $0) }
            .chunks(ofCount: 40)
            .filter { $0.count == 40 } // It is possible that the last signal is an addx that is finished after the last cycle
            .joined(separator: "\n")
        print(String(pixels))
        return String(pixels)
    }
    
}

extension Solver10: Solver {
    
    public func solve(using input: String) { parseStuff(from: input) }
    
    public var solutionPart1: String { String(answer1) }
    
    public var solutionPart2: String { answer2.converted }
    
}

extension Solver10: CustomStringConvertible {
    
    public var description: String {
        """
        \(descriptionTitle)
        
        The answer to part 1 is \(solutionPart1).
        The answer to part 2 is \(solutionPart2).
        """
    }
    
    private var descriptionTitle: String { "✼*✻*✼*✻* Day 10 *✻*✼*✻*✼" }
    
}

// MARK: - Supporting Types

enum Signal {
    
    case noop
    case addx(value: Int)
    
    init(from input: String) {
        switch input.prefix(4) {
        case "noop":
            self = .noop
            
        case "addx":
            guard let value = Int(input.dropFirst(5)) else { fatalError("Could not parse Int value for addx signal") }
            self = .addx(value: value)
            
        default:
            fatalError("Could not parse input")
        }
    }
    
    func process(on stream: inout [Int]) {
        guard let currentValue = stream.last else { fatalError("Processing a signal can only work on an existing stream (at least one value)") }
        switch self {
        case .noop:
            stream.append(currentValue)
            
        case let .addx(adjustmentValue):
            stream.append(currentValue)
            stream.append(currentValue + adjustmentValue)
        }
    }
    
}

fileprivate extension String {
    
    var converted: String {
        var characters: [OCRCharacter] = []
        let onelinedString = components(separatedBy: .newlines).joined()
        let characterCount = onelinedString.count / 30
        let chunks = onelinedString.chunks(ofCount: 5)
        for offset in 0...(characterCount - 1) {
            let indices = Array(stride(from: offset, to: chunks.count, by: characterCount))
            let characterPixels = indices.map { String(chunks[chunks.index(chunks.startIndex, offsetBy: $0)]).dropLast() }.joined()
            characters.append(OCRCharacter(characterPixels))
        }
        return String(characters.map(\.converted))
    }
    
    private enum OCRCharacter: String {
        
        // Known Characters from Reddit -> https://redd.it/zhm1hg
        
        case a = "011010011001111110011001"
        case b = "111010011110100110011110"
        case c = "011010011000100010010110"
        case e = "111110001110100010001111"
        case f = "111110001110100010001000"
        case g = "011010011000101110010111"
        case h = "100110011111100110011001"
        case j = "001100010001000110010110"
        case k = "100110101100101010101001"
        case l = "100010001000100010001111"
        case p = "111010011001111010001000"
        case r = "111010011001111010101001"
        case u = "100110011001100110010110"
        case z = "111100010010010010001111"
        case unknown = "Unknown Character"
        
        init(_ string: String) {
            let zeroOneConvertedString = string.replacingOccurrences(of: "█", with: "1").replacingOccurrences(of: " ", with: "0")
            self = OCRCharacter(rawValue: zeroOneConvertedString) ?? .unknown
        }
        
        var converted: Character {
            switch self {
            case .a: return "A"
            case .b: return "B"
            case .c: return "C"
            case .e: return "E"
            case .f: return "F"
            case .g: return "G"
            case .h: return "H"
            case .j: return "J"
            case .k: return "K"
            case .l: return "L"
            case .p: return "P"
            case .r: return "R"
            case .u: return "U"
            case .z: return "Z"
            case .unknown: 
                return "?"
            }
        }
        
    }
    
}
