//
// 💡 Advent of Code 2022 - Day 04
// 🎅🏽 Author: Benno Kress
//

import Foundation

public class Solver04 {
    
    var cleaningAssignmentPairs: [CleaningAssignmentPair] = []
    
    init() { }
    
    func parseStuff(from input: String) {
        let inputEntries = input.components(separatedBy: .newlines)
        for entry in inputEntries {
            addCleaningAssignmentPair(with: entry, to: &cleaningAssignmentPairs)
        }
    }
    
    /// The amount of assignment pairs where one assignment is fully contained in the other
    var answer1: Int {
        cleaningAssignmentPairs.filter(\.hasFullyContainedAssignment).count
    }
    
    /// The amount of assignment pairs where one assignment contains parts of the other
    var answer2: Int {
        cleaningAssignmentPairs.filter(\.areOverlapping).count
    }
    
    private func addCleaningAssignmentPair(with assignment: String, to cleaningAssignmentPairs: inout [CleaningAssignmentPair]) {
        let cleaningAssignmentPair = CleaningAssignmentPair(with: assignment)
        cleaningAssignmentPairs.append(cleaningAssignmentPair)
    }
    
}

extension Solver04: Solver {
    
    public func solve(using input: String) { parseStuff(from: input) }
    
    public var solutionPart1: String { String(answer1) }
    
    public var solutionPart2: String { String(answer2) }
    
}

extension Solver04: CustomStringConvertible {
    
    public var description: String {
        """
        \(descriptionTitle)
        
        The answer to part 1 is \(solutionPart1).
        The answer to part 2 is \(solutionPart2).
        """
    }
    
    private var descriptionTitle: String { "✼*✻*✼*✻* Day 04 *✻*✼*✻*✼" }
    
}

// MARK: - Supporting Types

struct CleaningAssignmentPair {
    
    let assignment1: ClosedRange<Int>
    let assignment2: ClosedRange<Int>
    
    init(with assignments: String) {
        let splitAssignments = assignments.split(separator: ",")
        let assignment1Boundaries = splitAssignments.first!.split(separator: "-").map { Int($0)! }
        let assignment2Boundaries = splitAssignments.last!.split(separator: "-").map { Int($0)! }
        self.assignment1 = assignment1Boundaries.first! ... assignment1Boundaries.last!
        self.assignment2 = assignment2Boundaries.first! ... assignment2Boundaries.last!
    }
    
    var hasFullyContainedAssignment: Bool { assignment1.contains(assignment2) || assignment2.contains(assignment1) }
    var areOverlapping: Bool { assignment1.overlaps(assignment2) || assignment2.overlaps(assignment1) }
    
}
