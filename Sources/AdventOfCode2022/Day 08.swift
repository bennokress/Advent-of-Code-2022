//
// 💡 Advent of Code 2022 - Day 08
// 🎅🏽 Author: Benno Kress
//

import Foundation

public class Solver08 {
    
    private var forest: [Tree] = []
    
    init() { }
    
    func parseStuff(from input: String) {
        let inputRows = input.components(separatedBy: .newlines)
        var maxColumn = 0
        var maxRow = 0
        for (rowIndex, row) in inputRows.enumerated() {
            for (columnIndex, tree) in row.enumerated() {
                let tree = Tree(row: rowIndex, column: columnIndex, height: Int(String(tree))!)
                forest.append(tree)
                maxColumn = max(columnIndex, maxColumn)
                maxRow = max(rowIndex, maxRow)
            }
        }
        forest.forEach {
            $0.evalute(in: forest, with: maxColumn, and: maxRow)
        }
    }
    
    /// The amount of trees visible from outside the forest
    var answer1: Int {
        forest
            .filter { $0.isVisibleFromOutside }
            .count
    }
    
    /// The scenic score of the best tree in the forest
    var answer2: Int {
        forest
            .map(\.scenicScore)
            .max()!
    }
    
}

extension Solver08: Solver {
    
    public func solve(using input: String) { parseStuff(from: input) }
    
    public var solutionPart1: String { String(answer1) }
    
    public var solutionPart2: String { String(answer2) }
    
}

extension Solver08: CustomStringConvertible {
    
    public var description: String {
        """
        \(descriptionTitle)
        
        The answer to part 1 is \(solutionPart1).
        The answer to part 2 is \(solutionPart2).
        """
    }
    
    private var descriptionTitle: String { "✼*✻*✼*✻* Day 08 *✻*✼*✻*✼" }
    
}

// MARK: - Supporting Types

class Tree {
    
    let row: Int
    let column: Int
    let height: Int
    
    var isVisibleFromOutside = false
    var scenicScore = 1
    
    func isEdgeTree(maxColumn: Int, maxRow: Int) -> Bool {
        row == 0 || column == 0 || row == maxRow || column == maxColumn
    }
    
    init(row: Int, column: Int, height: Int, isVisibleFromOutside: Bool = false, scenicScore: Int = 1) {
        self.row = row
        self.column = column
        self.height = height
        self.isVisibleFromOutside = isVisibleFromOutside
        self.scenicScore = scenicScore
    }
    
    func evalute(in forest: [Tree], with maxColumn: Int, and maxRow: Int) {
        guard !isEdgeTree(maxColumn: maxColumn, maxRow: maxRow) else { return skipFurtherEvaluation() }
        guard evaluateFromTop(in: forest) else { return skipFurtherEvaluation() }
        guard evaluateFromLeft(in: forest) else { return skipFurtherEvaluation() }
        guard evaluateFromRight(in: forest, with: maxColumn) else { return skipFurtherEvaluation() }
        evaluateFromBottom(in: forest, with: maxRow)
    }
    
    private func skipFurtherEvaluation() {
        self.isVisibleFromOutside = true
        self.scenicScore = 0
    }
    
    @discardableResult private func evaluateFromTop(in forest: [Tree]) -> Bool { 
        let viewBlockingTrees = forest.filter { $0.column == self.column && $0.row < self.row && $0.height >= self.height }
        let nearestViewBlockingTree = viewBlockingTrees.sorted { $0.row > $1.row }.first
        
        let isVisibleFromTop = nearestViewBlockingTree == nil
        self.isVisibleFromOutside = isVisibleFromOutside || isVisibleFromTop
        
        let nearestViewBlockingTreeRow = nearestViewBlockingTree?.row ?? 0
        let scenicScoreFromTop = self.row - nearestViewBlockingTreeRow
        self.scenicScore = scenicScore * scenicScoreFromTop
        
        let needsMoreEvaluation = scenicScore != 0 || !isVisibleFromOutside
        return needsMoreEvaluation
    }
    
    @discardableResult private func evaluateFromLeft(in forest: [Tree]) -> Bool {
        let viewBlockingTrees = forest.filter { $0.row == self.row && $0.column < self.column && $0.height >= self.height }
        let nearestViewBlockingTree = viewBlockingTrees.sorted { $0.column > $1.column }.first
        
        let isVisibleFromLeft = nearestViewBlockingTree == nil
        self.isVisibleFromOutside = isVisibleFromOutside || isVisibleFromLeft
        
        let nearestViewBlockingTreeColumn = nearestViewBlockingTree?.column ?? 0
        let scenicScoreFromLeft = self.column - nearestViewBlockingTreeColumn
        self.scenicScore = scenicScore * scenicScoreFromLeft
        
        let needsMoreEvaluation = scenicScore != 0 || !isVisibleFromOutside
        return needsMoreEvaluation
    }
    
    @discardableResult private func evaluateFromRight(in forest: [Tree], with maxColumn: Int) -> Bool { 
        let viewBlockingTrees = forest.filter { $0.row == self.row && $0.column > self.column && $0.height >= self.height }
        let nearestViewBlockingTree = viewBlockingTrees.sorted { $0.column < $1.column }.first
        
        let isVisibleFromRight = nearestViewBlockingTree == nil
        self.isVisibleFromOutside = isVisibleFromOutside || isVisibleFromRight
        
        let nearestViewBlockingTreeColumn = nearestViewBlockingTree?.column ?? maxColumn
        let scenicScoreFromRight = nearestViewBlockingTreeColumn - self.column
        self.scenicScore = scenicScore * scenicScoreFromRight
        
        let needsMoreEvaluation = scenicScore != 0 || !isVisibleFromOutside
        return needsMoreEvaluation
    }
    
    @discardableResult private func evaluateFromBottom(in forest: [Tree], with maxRow: Int) -> Bool { 
        let viewBlockingTrees = forest.filter { $0.column == self.column && $0.row > self.row && $0.height >= self.height }
        let nearestViewBlockingTree = viewBlockingTrees.sorted { $0.row < $1.row }.first
        
        let isVisibleFromBottom = nearestViewBlockingTree == nil
        self.isVisibleFromOutside = isVisibleFromOutside || isVisibleFromBottom
        
        let nearestViewBlockingTreeRow = nearestViewBlockingTree?.row ?? maxRow
        let scenicScoreFromBottom = nearestViewBlockingTreeRow - self.row
        self.scenicScore = scenicScore * scenicScoreFromBottom
        
        let needsMoreEvaluation = scenicScore != 0 || !isVisibleFromOutside
        return needsMoreEvaluation
    }
    
}
