//
// 💡 Advent of Code 2022 - Day 14
// 🎅🏽 Author: Benno Kress
//

import Foundation

public class Solver14 {
    
    init() { }
    
    /// Instructions what to do with the input
    func parseStuff(from input: String) {
        print(input)
    }
    
    /// Answer 1 Description
    var answer1: Int {
        0
    }
    
    /// Answer 2 Description
    var answer2: Int {
        0
    }
    
}

extension Solver14: Solver {
    
    public func solve(using input: String) { parseStuff(from: input) }
    
    public var solutionPart1: String { String(answer1) }
    
    public var solutionPart2: String { String(answer2) }
    
}

extension Solver14: CustomStringConvertible {
    
    public var description: String {
        """
        \(descriptionTitle)
        
        The answer to part 1 is \(solutionPart1).
        The answer to part 2 is \(solutionPart2).
        """
    }
    
    private var descriptionTitle: String { "✼*✻*✼*✻* Day 14 *✻*✼*✻*✼" }
    
}

// MARK: - Supporting Types

// Add whatever you need
