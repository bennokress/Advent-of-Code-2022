//
// 💡 Advent of Code 2022 - Day 01
// 🎅🏽 Author: Benno Kress
//

import Algorithms
import Foundation

public class Solver01 {
    
    /// Elves parsed from the input
    private var elves: [Elf] = []
    
    init() { }
    
    func parseElves(from input: String) {
        let inputEntries = input.components(separatedBy: .newlines)
        var caloriesCounter = 0
        for entry in inputEntries {
            if entry.isEmpty {
                addElf(with: caloriesCounter, to: &elves)
                caloriesCounter = 0
            } else {
                let calories = Int(entry)!
                caloriesCounter += calories
            }
        }
        addElf(with: caloriesCounter, to: &elves)
    }
    
    /// Calories count of the elf carrying the most calories
    var answer1: Int {
        elves.max()?.calories ?? 0
    }
    
    /// Calories count of the three elves carrying the most calories
    var answer2: Int {
        elves.max(count: 3).map(\.calories).reduce(0, +)
    }
    
    private func addElf(with calories: Int, to elves: inout [Elf]) {
        let id = elves.count + 1
        let elf = Elf(id: id, calories: calories)
        elves.append(elf)
    }
    
}

extension Solver01: Solver {
    
    public func solve(using input: String) { parseElves(from: input) }
    
    public var solutionPart1: String { String(answer1) }
    
    public var solutionPart2: String { String(answer2) }
    
}

extension Solver01: CustomStringConvertible {
    
    public var description: String {
        """
        \(descriptionTitle)
        
        The answer to part 1 is \(solutionPart1).
        The answer to part 2 is \(solutionPart2).
        
        The elves are:
        \(elvesDescription)
        """
    }
    
    private var descriptionTitle: String { "✼*✻*✼*✻* Day 01 *✻*✼*✻*✼" }
    private var elvesDescription: String { elves.map(\.description).joined(separator: "\n") }
    
}

// MARK: - Supporting Types

struct Elf: CustomStringConvertible, Comparable {    
    
    let id: Int
    let calories: Int
    
    static func < (lhs: Elf, rhs: Elf) -> Bool {
        lhs.calories < rhs.calories
    }
    
    var description: String {
        "\t• Elf #\(id) carries \(calories) calories"
    }
    
}
