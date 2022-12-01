//
// 💡 Solver Protocol
// 🎅🏽 Author: Benno Kress
//

import Foundation

public protocol Solver {
    
    func solve(using input: String)
    var solutionPart1: String { get }
    var solutionPart2: String { get }
    var description: String { get }
    
}
