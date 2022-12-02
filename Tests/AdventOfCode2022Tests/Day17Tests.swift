import XCTest
@testable import AdventOfCode2022

final class Day17Tests: XCTestCase {
    
    let input = """
        Paste example input here ...
        """
    
    func testExample() throws {
        let solver = Solver17()
        solver.solve(using: input)
        
        XCTAssertEqual(solver.answer1, 0)
        XCTAssertEqual(solver.answer2, 0)
    }
    
}
