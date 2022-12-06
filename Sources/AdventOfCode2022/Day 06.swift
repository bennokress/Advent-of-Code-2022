//
// 💡 Advent of Code 2022 - Day 06
// 🎅🏽 Author: Benno Kress
//

import Foundation

public class Solver06 {
    
    private var possibleMarkers: [String] = []
    private var possibleMessages: [String] = []
    
    init() { }
    
    func parseStuff(from input: String) {
        self.possibleMarkers = input.windows(ofCount: 4).enumerated().map { "\($1)\($0 + 4)" } // +4 to the index gives us the character at which the marker is complete
        self.possibleMessages = input.windows(ofCount: 14).enumerated().map { "\($1)\($0 + 14)" } // +14 to the index gives us the character at which the message is complete
    }
    
    /// This is the first index (1-based) of the last character of a marker which is defined as 4 characters without a duplicate
    var answer1: Int {
        firstMarkerIndex
    }
    
    /// This is the first index (1-based) of the last character of a message which is defined as 14 characters without a duplicate
    var answer2: Int {
        firstMessageIndex
    }
    
    private var firstMarkerIndex: Int {
        let culo = possibleMarkers
            .filter { isMarker($0) }
            .first!
            .dropFirst(4)
        return Int(String(culo))!
    }
    
    private func isMarker(_ possibleMarker: String) -> Bool {
        let chunk = possibleMarker.chunks(ofCount: 4).first!
        return Set(chunk).count == 4
    }
    
    private var firstMessageIndex: Int {
        let culo = possibleMessages
            .filter { isMessage($0) }
            .first!
            .dropFirst(14)
        return Int(String(culo))!
    }
    
    private func isMessage(_ possibleMessage: String) -> Bool {
        let chunk = possibleMessage.chunks(ofCount: 14).first!
        return Set(chunk).count == 14
    }
    
}

extension Solver06: Solver {
    
    public func solve(using input: String) { parseStuff(from: input) }
    
    public var solutionPart1: String { String(answer1) }
    
    public var solutionPart2: String { String(answer2) }
    
}

extension Solver06: CustomStringConvertible {
    
    public var description: String {
        """
        \(descriptionTitle)
        
        The answer to part 1 is \(solutionPart1).
        The answer to part 2 is \(solutionPart2).
        """
    }
    
    private var descriptionTitle: String { "✼*✻*✼*✻* Day 06 *✻*✼*✻*✼" }
    
}
