import XCTest
@testable import AdventOfCode2022

final class Day08Tests: XCTestCase {
    
    let input = """
        30373
        25512
        65332
        33549
        35390
        """
    
    func testExample() throws {
        let solver = Solver08()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, 21)
        XCTAssertEqual(solver.answer2, 8)
    }
    
}
