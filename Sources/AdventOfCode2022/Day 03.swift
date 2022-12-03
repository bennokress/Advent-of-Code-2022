//
// 💡 Advent of Code 2022 - Day 03
// 🎅🏽 Author: Benno Kress
//

import Foundation

public class Solver03 {
    
    /// Rucksacks parsed from the input
    private var rucksackGroups: [RucksackGroup] = []
    
    init() { }
    
    func parseRucksackContent(from input: String) {
        let inputEntries = input.components(separatedBy: .newlines)
        for entry in inputEntries.chunks(ofCount: 3) {
            let rucksacks = entry.map { Rucksack(with: $0) }
            addRucksackGroup(with: rucksacks, to: &rucksackGroups)
        }
    }
    
    /// Sum of the priorities of the item that appears in both compartments of each Rucksack
    var answer1: Int {
        rucksackGroups.map(\.individualRucksackPriorities).reduce(0, +)
    }
    
    /// Sum of priorities of the Rucksack Groups
    var answer2: Int {
        rucksackGroups.map(\.groupPriority).reduce(0, +)
    }
    
    private func addRucksackGroup(with rucksacks: [Rucksack], to rucksackGroups: inout [RucksackGroup]) {
        let rucksackGroup = RucksackGroup(with: rucksacks)
        rucksackGroups.append(rucksackGroup)
    }
    
}

extension Solver03: Solver {
    
    public func solve(using input: String) { parseRucksackContent(from: input) }
    
    public var solutionPart1: String { String(answer1) }
    
    public var solutionPart2: String { String(answer2) }
    
}

extension Solver03: CustomStringConvertible {
    
    public var description: String {
        """
        \(descriptionTitle)
        
        The answer to part 1 is \(solutionPart1).
        The answer to part 2 is \(solutionPart2).
        
        The rucksacks are:
        \(rucksacksDescription)
        """
    }
    
    private var descriptionTitle: String { "✼*✻*✼*✻* Day 03 *✻*✼*✻*✼" }
    private var rucksacksDescription: String { rucksackGroups.map(\.rucksacks).map(\.description).joined(separator: "\n") }
    
}

// MARK: - Supporting Types

struct RucksackGroup {
    
    var rucksacks: [Rucksack] = []
    
    init(with rucksacks: [Rucksack]) {
        self.rucksacks = rucksacks
    }
    
    var individualRucksackPriorities: Int { rucksacks.map(\.duplicateItem.priority).reduce(0, +) }
    var groupPriority: Int { groupIdentifier.priority }
    
    private var groupIdentifier: Character { 
        rucksacks
            .map { Set($0.content) }
            .reduce([], +)
            .getItemWithInclusionCount(3)
    }
    
}

struct Rucksack: CustomStringConvertible {
    
    let content: String
    
    private let compartment1Content: String
    private let compartment2Content: String
    
    init(with content: String) {
        self.content = content
        let splitContent = content.splitInHalf
        self.compartment1Content = splitContent.head
        self.compartment2Content = splitContent.tail
    }
    
    var duplicateItem: Character {
        let uniqueItemsInCompartment1 = Array(Set(compartment1Content))
        let uniqueItemsInCompartment2 = Array(Set(compartment2Content))
        let uniqueItemsOfBothCompartments = uniqueItemsInCompartment1 + uniqueItemsInCompartment2
        return uniqueItemsOfBothCompartments.getItemWithInclusionCount(2)
    }
    
    var description: String {
        "\t• [\(duplicateItem.priority)] Rucksack with duplicate item \(duplicateItem) from \(compartment1Content)·\(compartment2Content)"
    }
    
}

extension Array where Element == Character {
    
    func getItemWithInclusionCount(_ inclusionCount: Int) -> Character {
        self
            .reduce(into: [:]) { $0[$1, default: 0] += 1 }  // creates a dictionary of [character : count]
            .filter { $0.value == inclusionCount }          // gets all key-value-pairs that have the given (should be exactly a single matching pair according to the challenge description)
            .keys                                           // gets an array of the keys aka the one character that we're looking for
            .first!                                         // returns the first (and only) item from the array
    }
    
}

extension Character {
    
    var priority: Int { priorityLookupTable[self] ?? 0 }
    
    private var priorityLookupTable: [Character : Int] {
        let lowercaseCharacters = ("a"..."z").characters
        let uppercaseCharacters = ("A"..."Z").characters
        let possibleCharacters = lowercaseCharacters + uppercaseCharacters
        let possiblePriorities = Array(1...52)
        let zippedCharacterPriorities = zip(possibleCharacters, possiblePriorities)
        var priorityLookupTable: [Character : Int] = [:]
        for characterPriority in zippedCharacterPriorities {
            priorityLookupTable[characterPriority.0] = characterPriority.1
        }
        return priorityLookupTable
    }
    
}

extension ClosedRange where Bound == Unicode.Scalar {
    
    private var range: ClosedRange<UInt32> { lowerBound.value...upperBound.value }
    private var scalars: [Unicode.Scalar] { range.compactMap(Unicode.Scalar.init) }
    var characters: [Character] { scalars.map(Character.init) }
    
}

extension String {
    
    var splitInHalf: (head: String, tail: String) {
        let splitIndex = index(startIndex, offsetBy: count / 2)
        let head = self[startIndex ..< splitIndex]
        let tail = self[splitIndex ..< endIndex]
        return (String(head), String(tail))
    }
    
}
