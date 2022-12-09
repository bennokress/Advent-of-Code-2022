//
// 💡 Advent of Code 2022 - Day 09
// 🎅🏽 Author: Benno Kress
//

import Foundation

public class Solver09 {
    
    var visitedTailPositions: Set<RopePosition> = [RopePosition(x: 0, y: 0)]
    var visitedLongTailPositions: Set<RopePosition> = [RopePosition(x: 0, y: 0)]
    var head = RopePosition(x: 0, y: 0)
    var tail1 = RopePosition(x: 0, y: 0)
    var tail2 = RopePosition(x: 0, y: 0)
    var tail3 = RopePosition(x: 0, y: 0)
    var tail4 = RopePosition(x: 0, y: 0)
    var tail5 = RopePosition(x: 0, y: 0)
    var tail6 = RopePosition(x: 0, y: 0)
    var tail7 = RopePosition(x: 0, y: 0)
    var tail8 = RopePosition(x: 0, y: 0)
    var tail9 = RopePosition(x: 0, y: 0)
    
    init() { }
    
    func parseStuff(from input: String) {
        let inputEntries = input.components(separatedBy: .newlines)
        for inputEntry in inputEntries {
            let instruction = inputEntry.components(separatedBy: .whitespaces)
            let repetitions = Int(instruction.last!)!
            let direction = RopePosition.MoveDirection(rawValue: instruction.first!)!
            for _ in 1...repetitions {
                self.head = head.nextPosition(moving: direction)
                self.tail1 = tail1.nextPosition(dependingOn: head)
                self.tail2 = tail2.nextPosition(dependingOn: tail1)
                self.tail3 = tail3.nextPosition(dependingOn: tail2)
                self.tail4 = tail4.nextPosition(dependingOn: tail3)
                self.tail5 = tail5.nextPosition(dependingOn: tail4)
                self.tail6 = tail6.nextPosition(dependingOn: tail5)
                self.tail7 = tail7.nextPosition(dependingOn: tail6)
                self.tail8 = tail8.nextPosition(dependingOn: tail7)
                self.tail9 = tail9.nextPosition(dependingOn: tail8)
                self.visitedTailPositions.insert(tail1)
                self.visitedLongTailPositions.insert(tail9)
            }
        }
    }
    
    /// How many positions was the tail of the short rope on at least once?
    var answer1: Int {
        visitedTailPositions.count
    }
    
    /// How many positions was the tail of the long rope on at least once?
    var answer2: Int {
        visitedLongTailPositions.count
    }
    
}

extension Solver09: Solver {
    
    public func solve(using input: String) { parseStuff(from: input) }
    
    public var solutionPart1: String { String(answer1) }
    
    public var solutionPart2: String { String(answer2) }
    
}

extension Solver09: CustomStringConvertible {
    
    public var description: String {
        """
        \(descriptionTitle)
        
        The answer to part 1 is \(solutionPart1).
        The answer to part 2 is \(solutionPart2).
        """
    }
    
    private var descriptionTitle: String { "✼*✻*✼*✻* Day 09 *✻*✼*✻*✼" }
    
}

// MARK: - Supporting Types

struct RopePosition: Equatable, Identifiable, Hashable {
    
    let x, y: Int
    
    var id: String { description }
    var description: String { "[\(x),\(y)]" }
    
    func nextPosition(moving direction: MoveDirection) -> RopePosition {
        switch direction {
        case .up: return RopePosition(x: x, y: y + 1)
        case .down: return RopePosition(x: x, y: y - 1)
        case .left: return RopePosition(x: x - 1, y: y)
        case .right: return RopePosition(x: x + 1, y: y)
        }
    }
    
    func nextPosition(dependingOn head: RopePosition) -> RopePosition {
        guard !isAdjacent(to: head) else { return self }
        let distance = (x: horizontalDistance(to: head), y: verticalDistance(to: head))
        let nextX = (abs(distance.x) < 1) ? x : (x + distance.x.signum())
        let nextY = (abs(distance.y) < 1) ? y : (y + distance.y.signum())
        return RopePosition(x: nextX, y: nextY)
    }
    
    private func isAdjacent(to otherPosition: RopePosition) -> Bool {
        abs(horizontalDistance(to: otherPosition)) <= 1 && abs(verticalDistance(to: otherPosition)) <= 1
    }
    
    private func horizontalDistance(to otherPosition: RopePosition) -> Int {
        otherPosition.x - x
    }
    
    private func verticalDistance(to otherPosition: RopePosition) -> Int {
        otherPosition.y - y
    }
    
    enum MoveDirection: String {
        case up = "U"
        case down = "D"
        case left = "L"
        case right = "R"
    }
    
}
