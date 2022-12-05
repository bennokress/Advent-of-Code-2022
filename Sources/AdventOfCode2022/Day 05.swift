//
// 💡 Advent of Code 2022 - Day 05
// 🎅🏽 Author: Benno Kress
//

import Foundation

public class Solver05 {
    
    /// Crate Stacks State where first element is the one on top
    private var stacksAfterSinglesOperation: [String] = []
    private var stacksAfterMultiplesOperation: [String] = []
    
    init() { }
    
    func parseStuff(from input: String) {
        let inputEntries = input.split(separator: "\n\n")
        let instructions = inputEntries.last!.components(separatedBy: .newlines).map { StackOperationInstruction($0) }
        
        var singlesStacks = CrateStacks(from: String(inputEntries.first!))
        for instruction in instructions { instruction.useCrateMover9000(on: &singlesStacks) }
        self.stacksAfterSinglesOperation = singlesStacks.currentState
        
        var multiplesStacks = CrateStacks(from: String(inputEntries.first!))
        for instruction in instructions { instruction.useCrateMover9001(on: &multiplesStacks) }
        self.stacksAfterMultiplesOperation = multiplesStacks.currentState
    }
    
    /// The top crate of each stack after using the instructions to move one crate at a time (CrateMover 9000)
    var answer1: String {
        String(stacksAfterSinglesOperation.map(\.first!))
    }
    
    /// The top crate of each stack after using the instructions to move all crates from a single stack at the same time (CrateMover 9001)
    var answer2: String {
        String(stacksAfterMultiplesOperation.map(\.first!))
    }
    
}

extension Solver05: Solver {
    
    public func solve(using input: String) { parseStuff(from: input) }
    
    public var solutionPart1: String { answer1 }
    
    public var solutionPart2: String { answer2 }
    
}

extension Solver05: CustomStringConvertible {
    
    public var description: String {
        """
        \(descriptionTitle)
        
        The answer to part 1 is \(solutionPart1).
        The answer to part 2 is \(solutionPart2).
        """
    }
    
    private var descriptionTitle: String { "✼*✻*✼*✻* Day 05 *✻*✼*✻*✼" }
    
}

// MARK: - Supporting Types

struct StackOperationInstruction {
    
    let amount: Int
    let originStackIndex: Int
    let destinationStackIndex: Int
    
    init(_ input: String) {
        let inputWordsAndNumbers = input.components(separatedBy: .whitespaces)
        let numbersFromInput = inputWordsAndNumbers.compactMap { Int(String($0)) }
        self.amount = numbersFromInput[0]
        self.originStackIndex = numbersFromInput[1] - 1 // lower index by 1
        self.destinationStackIndex = numbersFromInput[2] - 1 // lower index by 1
    }
    
    func useCrateMover9000(on stacks: inout CrateStacks) {
        stacks.moveSingles(amount, from: originStackIndex, to: destinationStackIndex)
    }
    
    func useCrateMover9001(on stacks: inout CrateStacks) {
        stacks.moveMultiples(amount, from: originStackIndex, to: destinationStackIndex)
    }
    
}

struct CrateStacks {
    
    private(set) var currentState: [String]
    
    init(from input: String) {
        var inputEntries: [String] = input.components(separatedBy: .newlines)
        let stackAmount = inputEntries.removeLast().compactMap { Int(String($0)) }.max()!
        var stacks: [String] = Array(repeating: "", count: stackAmount)
        for inputEntry in inputEntries {
            for (index, stackElement) in inputEntry.chunks(ofCount: 4).enumerated() {
                if let crate = stackElement.first(where: \.isLetter) {
                    stacks[index].append(crate)
                }
            }
        }
        self.currentState = stacks
    }
    
    mutating func moveSingles(_ amount: Int, from originStackIndex: Int, to destinationStackIndex: Int) {
        for _ in 1...amount {
            let movingCrate = currentState[originStackIndex].removeFirst()
            currentState[destinationStackIndex] = "\(movingCrate)\(currentState[destinationStackIndex])"
        }
    }
    
    mutating func moveMultiples(_ amount: Int, from originStackIndex: Int, to destinationStackIndex: Int) {
        let movingCrates = currentState[originStackIndex].chunks(ofCount: amount).first!
        currentState[originStackIndex].removeFirst(amount)
        currentState[destinationStackIndex] = "\(movingCrates)\(currentState[destinationStackIndex])"
    }
    
}
