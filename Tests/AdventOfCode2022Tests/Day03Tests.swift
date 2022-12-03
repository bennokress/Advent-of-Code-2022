import XCTest
@testable import AdventOfCode2022

final class Day03Tests: XCTestCase {
    
    let input = """
        vJrwpWtwJgWrhcsFMMfFFhFp
        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
        PmmdzqPrVvPwwTWBwg
        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
        ttgJtRGJQctTZtZT
        CrZsJsPPZsGzwwsLwLmpwMDw
        """
    
    func testExample() throws {
        let solver = Solver03()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, 157)
        XCTAssertEqual(solver.answer2, 70)
    }
    
}
