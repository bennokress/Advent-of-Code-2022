//
// 💡 Advent of Code 2022
// 🎅🏽 Author: Benno Kress
//

import Foundation

public struct AdventOfCode2022 {
    
    static public func solver(for challenge: Challenge, with input: String) -> (any Solver)? {
        guard let solver = emptySolver(for: challenge) else { return nil }
        solver.solve(using: input)
        return solver
    }
    
    static private func emptySolver(for challenge: Challenge) -> (any Solver)? {
        switch challenge.rawValue {
        case 1: return Solver01()
        case 2: return Solver02()
        case 3: return Solver03()
        case 4: return Solver04()
        case 5: return Solver05()
        case 6: return Solver06()
        case 7: return Solver07()
        case 8: return Solver08()
        case 9: return Solver09()
        case 10: return Solver10()
        case 11: return Solver11()
        case 12: return Solver12()
        case 13: return Solver13()
        case 14: return Solver14()
        case 15: return Solver15()
        case 16: return Solver16()
        case 17: return Solver17()
        case 18: return Solver18()
        case 19: return Solver19()
        case 20: return Solver20()
        case 21: return Solver21()
        case 22: return Solver22()
        case 23: return Solver23()
        case 24: return Solver24()
        case 25: return Solver25()
        default:
            return nil
        }
    }
    
}
